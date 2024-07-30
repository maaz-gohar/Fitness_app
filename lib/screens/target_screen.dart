import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TargetScreen extends StatefulWidget {
  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Your Target',
          style: TextStyle(
            fontWeight: FontWeight.bold,


          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: fitnessData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDataRow('Situps', fitnessData['Situps']),
              buildDataRow('Squats', fitnessData['Squats']),
              buildDataRow('Lunges', fitnessData['Lunges']),
              buildDataRow('Plank', fitnessData['Plank']),
              buildDataRow('Pushups', fitnessData['Pushups']),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataRow(String title, dynamic value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          Text(
            value != null ? value.toString() : 'N/A',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
