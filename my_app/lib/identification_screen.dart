import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'prediction_result_screen.dart';
import 'dart:developer';


class IdentificationScreen extends StatefulWidget {
  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  
  List<String>? questions;
  List<int?> answers = [];
  // List<int?> answers = List.filled(22, null); // Define the 'answers' list
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }
  

  void fetchQuestions() async {
  var client = http.Client();
  var uri = Uri.parse("http://127.0.0.1:5000/get_questions");

  try {
    var resp = await client.get(uri);
    if (resp.statusCode == 200) {
      Map<String, dynamic> data = json.decode(resp.body);

      // Remove underscores from questions
      setState(() {
        questions = List<String>.from(data['questions'])
            .map((question) => question.replaceAll('_', ' '))
            .toList();
        answers = List.filled(questions!.length, null);
      });
    } else {
      print('Failed to load questions. Status code: ${resp.statusCode}');
    }
  } catch (e) {
    print('An error occurred while fetching questions: $e');
  } finally {
    client.close();
  }
}


// CORRECT VERSION OF SENDANSWERS (I'M WORKING ON )

  void sendAnswers(List<int?> answers) async {
  var client = http.Client();
  var uri = Uri.parse("http://127.0.0.1:5000/predict");
  
  Map<String, dynamic> requestBody = {};

  for (int i = 0; i < answers.length; i++) {
    if (answers[i] != null) {
      requestBody[questions![i]] = answers[i];
    }
  }
  print('Request Body: $requestBody');

  try {
    var resp = await client.post(
      uri,
      headers: {"Content-type": "application/json"},
      body: jsonEncode([requestBody]),  
    );

    print('Response status code: ${resp.statusCode}');

    if (resp.statusCode == 200) {
      Map<String, dynamic> data = json.decode(resp.body);
      print('Decoded data: $data');

      print("DATA FETCHED SUCCESSFULLY");
      var result = json.decode(resp.body);
      print(result["prediction"]);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PredictionResultScreen(studentName: result['prediction']?? 'Default Name'),
      ));
    } else {
      print('Failed to load data. Status code: ${resp.statusCode}');
      showErrorSnackBar('Failed to load data: ${resp.body}');
    }

  } catch (e) {
    showErrorSnackBar('An error occurred: $e');
  } finally {
    client.close();
  }
}
  


  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
  


  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFFFF5EE),
    appBar: AppBar(
      title: Text(
        'Student Identification System',
        style: TextStyle(
          color: Colors.black, // Match the homepage text color
          
        ),
      ),
      backgroundColor: Color(0xFFFAF0E6), // Match the homepage color
    ),
    body: Center(
      child: questions != null
          ? buildQuestionContent()
          : CircularProgressIndicator(),
    ),
  );
}

Widget buildQuestionContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        questions![currentQuestionIndex],
        style: TextStyle(fontSize: 24, color: Colors.black), // Match the homepage text color
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: () => answerQuestion(1),
        child: Text(
          'Yes',
          style: TextStyle(color: Colors.black), // Match the homepage text color
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Match the homepage color
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: () => answerQuestion(0),
        child: Text(
          'No',
          style: TextStyle(color: Colors.black), // Match the homepage text color
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Match the homepage color
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: () => answerQuestion(2),
        child: Text(
          "I don't know",
          style: TextStyle(color: Colors.black), // Match the homepage text color
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
  );
}


 
  void answerQuestion(int answer) {
    setState(() {
      answers[currentQuestionIndex] = answer;
      if (currentQuestionIndex < questions!.length - 1) {
        currentQuestionIndex++;
      } else {
        sendAnswers(answers);
      }
    });
  }

  

}
 
  

