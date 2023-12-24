import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'identification_screen.dart';

class MyImageSlider extends StatefulWidget {
  const MyImageSlider({super.key});

  @override
  State<MyImageSlider> createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {
  final myitems = [
    Image.asset('assets/images/image1.jpeg'),
    Image.asset('assets/images/image2.jpeg'),
    Image.asset('assets/images/image3.jpeg'),
    Image.asset('assets/images/image4.jpeg'),
    Image.asset('assets/images/image5.jpeg'),
    Image.asset('assets/images/image6.jpeg'),
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5EE), //0xFFFFFAFA
      appBar: AppBar(
        title: const Text(
          'Student Identification System',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 3,
        backgroundColor: Color(0xFFFAF0E6), 
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Add some spacing here
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 200,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 2),
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
            ),
            items: myitems,
          ),
          AnimatedSmoothIndicator(
            activeIndex: myCurrentIndex,
            count: myitems.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 10,
              dotColor: Colors.grey.shade200,
              activeDotColor: Colors.grey.shade400,
              paintStyle: PaintingStyle.fill,
            ),
          ),
          SizedBox(height: 20), // Add some spacing here
          Spacer(), // Center the content vertically
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Student Identification',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IdentificationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
              ),
            ],
          ),
          Spacer(), // Use Spacer to push the instructional text to the center
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Instructions: Think about someone, answer a series of questions, and the app will predict the student\'s name based on your responses. Have fun exploring!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 90), // Adjust the height as needed
        ],
      ),
    );
  }
}
