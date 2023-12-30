import 'package:demo/secondScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController sentenceController = TextEditingController();
  String resultMessage = "";

  void checkPalindrome() {
    String sentence = sentenceController.text.toLowerCase().replaceAll(" ", "");
    String reversedSentence = sentence.split('').reversed.join('');
    String result;

    if (sentence == reversedSentence) {
      result = 'isPalindrome';
    } else {
      result = 'Not Palindrome';
    }

    // Show the result in a pop-up dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Palindrome Result'),
          content: Text(result),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  'assets/images/pp.jpg',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    // labelText: 'Name',
                    hintText: 'Name',
                    hintStyle: GoogleFonts.poppins(),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: sentenceController,
                  decoration: InputDecoration(
                      // labelText: 'Sentence',
                      hintText: 'Sentence',
                      hintStyle: GoogleFonts.poppins(),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 53, 121, 151)),
                    ),
                    onPressed: () {
                      checkPalindrome();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 90),
                      child: Text('Check',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 53, 121, 151)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SecondScreen(userName: nameController.text),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        'Next',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
