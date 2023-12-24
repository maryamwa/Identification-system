// import 'package:flutter/material.dart';
// import 'package:my_app/identification_screen.dart';

// void main() {
//   runApp(StudentIdentificationApp());
// }

// class StudentIdentificationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Identification',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false, // Remove the debug banner
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Identification System'),
//         centerTitle: true,
//         backgroundColor: Color(0xFFE6D7B9), // Beige color
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.school,
//               size: 80,
//               color: Color(0xFFE6D7B9), // Beige color
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Welcome to Student Identification',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => IdentificationScreen()),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   'Start Identification',
//                   style: TextStyle(fontSize: 20, color: Colors.black), // Black text color
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: Color(0xFFE6D7B9), // Beige color
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_app/identification_screen.dart';
import 'package:my_app/auto_image_slider.dart';

void main() {
  runApp(StudentIdentificationApp());
}

class StudentIdentificationApp extends StatelessWidget {
  const StudentIdentificationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyImageSlider(),
      debugShowCheckedModeBanner: false,
    );
  }
}