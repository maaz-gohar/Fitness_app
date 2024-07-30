import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final int progress;
  final Function(String, int) updateProgress;

  ExerciseTile({
    required this.exercise,
    required this.progress,
    required this.updateProgress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exercise.name),
      subtitle: Text('Target: ${exercise.target} sets'),
      trailing: Text('Completed: $progress sets'),
      onTap: () => _showUpdateDialog(context),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final TextEditingController setsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Progress'),
          content: TextField(
            controller: setsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Sets completed'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int sets = int.parse(setsController.text);
                updateProgress(exercise.name, sets);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
