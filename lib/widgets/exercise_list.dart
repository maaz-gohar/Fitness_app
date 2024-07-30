import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  final Map<String, int> userProgress;
  final Function(String, int) updateProgress;

  ExerciseList({
    required this.exercises,
    required this.userProgress,
    required this.updateProgress,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        var exercise = exercises[index];
        var progress = userProgress[exercise.name] ?? 0;
        return ExerciseTile(
          exercise: exercise,
          progress: progress,
          updateProgress: updateProgress,
        );
      },
    );
  }
}
