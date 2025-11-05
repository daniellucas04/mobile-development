import 'package:aula12/models/task.dart';
import 'package:aula12/screens/create_task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o banco de dados
  database = openDatabase(
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
  @override
  void initState() {
    super.initState();
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
      body: Container(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Task>>(
              future: _fetchAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Task> tasks = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Task task = tasks[index];

                        return Card(
                          color: Colors.grey.shade200,
                          borderOnForeground: true,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(12),
                            title: Text(
                              task.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(task.status),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    task.status.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextButton.icon(
                                  icon: Icon(Icons.arrow_forward),
                                  iconAlignment: IconAlignment.end,
                                  label: Text('Change status'),
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No tasks found.'));
                }
              },
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
                  onPressed: () {
                    Navigator.of(context).push(_createTaskScreen());
                  },
                  icon: Icon(Icons.add, size: 24),
                  label: Text('Nova tarefa', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  Future<List<Task>> _fetchAllTasks() async {
    final db = await database;
    final List<Map<String, Object?>> tasksMap = await db.query('tasks');

    return tasksMap.map((taskMap) {
      return Task(
        id: taskMap['id'] as int,
        title: taskMap['title'] as String,
        description: taskMap['description'] as String,
        status: taskMap['status'] as String,
        createdAt: DateTime.parse(taskMap['created_at'] as String),
        updatedAt: DateTime.parse(taskMap['updated_at'] as String),
      );
    }).toList();
  }

  _updateTaskStatus(Task task) async {
    final db = await database;

    task.status = task.status == 'pending'
        ? 'progress'
        : task.status == 'progress'
        ? 'done'
        : 'pending';

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
}
