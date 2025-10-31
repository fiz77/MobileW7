import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    final task = _controller.text;
    Provider.of<TaskProvider>(context, listen: false).addTask(task);
    _controller.clear();
  }

  void _editTaskDialog(int index, String currentTask) {
    final TextEditingController editController = TextEditingController(
      text: currentTask,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Tugas'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(labelText: 'Ubah tugas'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<TaskProvider>(
                context,
                listen: false,
              ).editTask(index, editController.text);
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Tambah Tugas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addTask, child: const Text('Tambah')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(tasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editTaskDialog(index, tasks[index]),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => Provider.of<TaskProvider>(
                          context,
                          listen: false,
                        ).deleteTask(index),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
