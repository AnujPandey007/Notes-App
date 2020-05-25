import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            "Splash Screen",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}