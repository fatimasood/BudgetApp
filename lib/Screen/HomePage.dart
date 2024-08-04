import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ViewData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(_createRoute());
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ViewData(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade300, Colors.red.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Center(
                child: Image.asset("lib/assets/logo.png"),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Saver Solutions',
                style: GoogleFonts.raleway(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white70),
              ),
            ),

            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(182, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
