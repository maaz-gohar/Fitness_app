import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'start_screen.dart'; // Ensure you import the StartScreen

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _situpsController = TextEditingController();
  final TextEditingController _squatsController = TextEditingController();
  final TextEditingController _lungesController = TextEditingController();
  final TextEditingController _plankController = TextEditingController();
  final TextEditingController _pushupsController = TextEditingController();

  Map<String, dynamic> fitnessData = {};

  @override
  void initState() {
    super.initState();
    fetchFitnessData();
  }

  Future<void> fetchFitnessData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/fitness/target.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            fitnessData = data[0]; // Assuming the first object contains the required data
          });
        }
      } else {
        throw Exception('Failed to load fitness data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void checkAndUpdateTargets() {
    if (_formKey.currentState!.validate()) {
      Map<String, String> results = {};

      fitnessData.forEach((key, value) {
        int enteredValue = int.parse(_getController(key).text);
        if (enteredValue == value) {
          results[key] = 'You achieved the target of $key';
        } else if (enteredValue > value) {
          results[key] = 'You achieve more then the tarhet of $key';
          // Update the target in the database
          updateTargetInDatabase(key, enteredValue);
        } else {
          results[key] = 'You didn\'t match the target of $key';
        }
      });

      showResultsDialog(results);
    }
  }

  TextEditingController _getController(String key) {
    switch (key) {
      case 'Situps':
        return _situpsController;
      case 'Squats':
        return _squatsController;
      case 'Lunges':
        return _lungesController;
      case 'Plank':
        return _plankController;
      case 'Pushups':
        return _pushupsController;
      default:
        return TextEditingController();
    }
  }

  Future<void> updateTargetInDatabase(String exercise, int value) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/fitness/update_target.php'),
        body: json.encode({
          'exercise': exercise,
          'value': value,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update target');
      }
    } catch (e) {
      print('Error updating target: $e');
    }
  }

  void showResultsDialog(Map<String, String> results) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: results.values
                .map((result) => Text(result, style: TextStyle(fontSize: 16)))
                .toList(),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // This will navigate back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Update Your Target',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: fitnessData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildInputField('Situps', _situpsController),
                  SizedBox(height: 20),
                  buildInputField('Squats', _squatsController),
                  SizedBox(height: 20),
                  buildInputField('Lunges', _lungesController),
                  SizedBox(height: 20),
                  buildInputField('Plank', _plankController),
                  SizedBox(height: 20),
                  buildInputField('Pushups', _pushupsController),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: checkAndUpdateTargets,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.deepPurple.shade50,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}

