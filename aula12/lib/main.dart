import 'package:aula12/models/task.dart';
import 'package:aula12/screens/create_task.dart';
import 'package:aula12/screens/update_task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o banco de dados
  database = await openDatabase(
    join(await getDatabasesPath(), 'tasks.db'),
    onCreate: (db, version) {
      return db.execute(''' 
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT, 
          description TEXT, 
          status TEXT, 
          created_at TEXT, 
          updated_at TEXT
        );
      ''');
    },
    version: 1,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Tasks', home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Route<void> _createTaskScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CreateTask(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  Route<void> _updateTaskScreen(Task task) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          UpdateTask(task: task),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  Future<void> _loadTasks() async {
    final db = await database;
    final List<Map<String, Object?>> tasksMap = await db.query('tasks');

    setState(() {
      _tasks = tasksMap.map((taskMap) {
        return Task(
          id: taskMap['id'] as int,
          title: taskMap['title'] as String,
          description: taskMap['description'] as String,
          status: taskMap['status'] as String,
          createdAt: DateTime.parse(taskMap['created_at'] as String),
          updatedAt: DateTime.parse(taskMap['updated_at'] as String),
        );
      }).toList();
      _isLoading = false;
    });
  }

  Future<void> _updateTaskStatus(Task task) async {
    final db = await database;

    setState(() {
      task.status = task.status == 'pending'
          ? 'progress'
          : task.status == 'progress'
          ? 'done'
          : 'pending';
    });

    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'done':
        return Colors.green.withAlpha(170);
      case 'progress':
        return Colors.orange.withAlpha(170);
      case 'pending':
        return Colors.blue.withAlpha(170);
      default:
        return Colors.grey.withAlpha(170);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        centerTitle: true,
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadTasks,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            spacing: 14,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'All tasks',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _tasks.isEmpty
                    ? const Center(child: Text('No tasks found.'))
                    : ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          return _taskCard(task);
                        },
                      ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.indigoAccent,
                      ),
                    ),
                    onPressed: () async {
                      final created = await Navigator.push(
                        this.context,
                        MaterialPageRoute(builder: (_) => CreateTask()),
                      );

                      if (created == true) {
                        _loadTasks();
                      }
                    },
                    icon: Icon(Icons.add, size: 24),
                    label: Text('Nova tarefa', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskCard(Task task) {
    return GestureDetector(
      onTap: () async {
        final updated = await Navigator.push(
          this.context,
          MaterialPageRoute(builder: (_) => UpdateTask(task: task)),
        );

        if (updated == true) {
          _loadTasks();
        }
      },
      child: Card(
        elevation: 2,
        shadowColor: Colors.black12,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: _getStatusColor(task.status),
                  shape: BoxShape.circle,
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),

                    AnimatedContainer(
                      width: 100,
                      key: ValueKey(task.id),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(task.status).withAlpha(25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        ),
                        child: Text(
                          task.status.toUpperCase(),
                          key: ValueKey(task.status),
                          style: TextStyle(
                            color: _getStatusColor(task.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              TextButton.icon(
                icon: const Icon(
                  Icons.sync_alt,
                  color: Colors.indigoAccent,
                  size: 18,
                ),
                label: const Text(
                  'Alterar',
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    task.status = task.status == 'pending'
                        ? 'progress'
                        : task.status == 'progress'
                        ? 'done'
                        : 'pending';
                  });

                  await _updateTaskStatus(task);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.indigoAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
