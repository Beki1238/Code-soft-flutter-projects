import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> tasks = [];
  TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      // For simplicity, we're just toggling a visual indicator.
      // You can add a proper completion state if needed.
      tasks[index] = tasks[index].startsWith('✓ ') ? tasks[index].substring(2) : '✓ ${tasks[index]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF153677), // Background color
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header with Icon
              Row(
                children: [
                  Icon(Icons.list, color: Colors.white, size: 30),
                  SizedBox(width: 10),
                  Text(
                    'To-Do List',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Task Input Row
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          hintText: 'Add your text here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Color(0xFF4e085f)),
                      onPressed: _addTask,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Task List
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(
                            tasks[index].startsWith('✓ ') ? Icons.check_circle : Icons.circle_outlined,
                            color: Color(0xFF4e085f),
                          ),
                          onPressed: () => _toggleTaskCompletion(index),
                        ),
                        title: Text(
                          tasks[index].startsWith('✓ ') ? tasks[index].substring(2) : tasks[index],
                          style: TextStyle(
                            decoration: tasks[index].startsWith('✓ ') ? TextDecoration.lineThrough : null,
                            color: tasks[index].startsWith('✓ ') ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}