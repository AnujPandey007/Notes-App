import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nosql/home.dart';


class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ProxyNotes",
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () { //Time Duration i.e., for how much time you want to show the splashscreen
      Navigator.pushReplacement(context, MaterialPageRoute(   
        builder: (context) => Home(), // Name of the Page that you want to go
      ));
    });
  }

  //SplashScreen Main Code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Text(
            "Splash Screen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0
            ),
          )
        )
      ),
    );
  }
}