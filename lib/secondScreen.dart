import 'package:demo/thirdScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondScreen extends StatefulWidget {
  final String userName;

  SecondScreen({required this.userName});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selectedUserName = "";

  void _navigateToThirdScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThirdScreen()),
    );
    if (result != null && result is String) {
      setState(() {
        selectedUserName = result;
      });
    } else {
      setState(() {
        selectedUserName = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: GoogleFonts.poppins(fontSize: 18)),
            Padding(
              padding: const EdgeInsets.only(top: 2, right: 0),
              child: Text(
                widget.userName,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Text('Selected User Name',
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Text(selectedUserName,
                  style: GoogleFonts.poppins(fontSize: 24)),
            ),
            SizedBox(height: 20),
            Spacer(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 53, 121, 151)),
                ),
                onPressed: () {
                  _navigateToThirdScreen(context);
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 90),
                    child: Text('Choose a User',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
