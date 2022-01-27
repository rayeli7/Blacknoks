import 'dart:async';

import 'package:blacknoks/main.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2000),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => const AuthenticationWrapper(),),),);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Image(
        image: AssetImage("assets/images/Union2.png")
        )
        );
  }
}

