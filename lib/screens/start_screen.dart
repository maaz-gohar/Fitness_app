import 'package:fitness/screens/target_screen.dart';
import 'package:fitness/screens/update_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TargetScreen(), // Navigate to your target screen
                  ),
                );
              },
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image(
                      height: 230,
                      width: 230,
                      image: AssetImage('img/asset/target.png'), // Update with your image asset
                    ),
                    Text(
                      'Your Target',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateScreen(), // Navigate to your workout screen
                  ),
                );
              },
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image(
                      height: 230,
                      width: 230,
                      image: AssetImage('img/asset/update.png'), // Update with your image asset
                    ),
                    Text(
                      'Your Today Workout',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
