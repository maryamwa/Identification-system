

import 'package:flutter/material.dart';

class PredictionResultScreen extends StatelessWidget {
  final String studentName;

  PredictionResultScreen({required this.studentName}) {
    print('Received studentName: $studentName');
  }

  @override
  Widget build(BuildContext context) {
    print('Building PredictionResultScreen with studentName: $studentName');

    return Scaffold(
      backgroundColor: Color(0xFFFFF5EE),
      appBar: AppBar(
        title: Text(
          'Prediction Result',
          style: TextStyle(
            color: Colors.black, // Match the homepage text color
            
          ),
        ),
        backgroundColor: Color(0xFFFAF0E6), // Match the homepage color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are thinking about:',
              style: TextStyle(fontSize: 20, color: Colors.black), // Match the homepage text color
            ),
            SizedBox(height: 10),
            Text(
              studentName ?? 'Default Name', // Provide a default value or placeholder
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Match the homepage text color
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add any actions you want to perform after displaying the result
                print('Navigating back to the identification screen');
                Navigator.pop(context); // Navigate back to the identification screen
              },
              child: Text('Back to Identification', style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Match the homepage color
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
