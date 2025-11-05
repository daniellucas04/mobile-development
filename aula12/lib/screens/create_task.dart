import 'package:aula12/main.dart';
import 'package:aula12/models/task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New task'),
        centerTitle: true,
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 12,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Title',
                    ),
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "The title is required";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Description',
                    ),
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "The description is required";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Status',
                    ),
                    controller: statusController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "The status is required";
                      }

                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.icon(
                        onPressed: _submitForm,
                        icon: Icon(Icons.add_circle, size: 24),
                        label: Text(
                          'Create new task',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final db = await database;

      Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        status: statusController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      db.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 6,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'New task created',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
        ),
      );

      Navigator.pop(context);
    }
  }
}
