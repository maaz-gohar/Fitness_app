import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../widgets/exercise_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Exercise> _exercises = [
    Exercise(name: 'Push-ups', target: 10),
    Exercise(name: 'Sit-ups', target: 20),
    Exercise(name: 'Squats', target: 15),
    Exercise(name: 'Lunges', target: 12),
    Exercise(name: 'Plank', target: 1), // Plank in minutes
    // Add more exercises here if needed
  ];

  Map<String, int> _userProgress = {};

  void _updateProgress(String exerciseName, int sets) {
    setState(() {
      if (_userProgress.containsKey(exerciseName)) {
        _userProgress[exerciseName] = _userProgress[exerciseName]! + sets;
      } else {
        _userProgress[exerciseName] = sets;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
      ),
      body: ExerciseList(
        exercises: _exercises,
        userProgress: _userProgress,
        updateProgress: _updateProgress,
      ),
    );
  }
}
