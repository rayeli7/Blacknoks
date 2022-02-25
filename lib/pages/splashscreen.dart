import 'dart:async';

import 'package:blacknoks/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/livedata_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      var p = Provider.of<LiveProvider>(context, listen: false);
      p.getLiveStockData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthenticationWrapper(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: const Image(
            image: AssetImage("assets/images/blacknocks_logo_white.png")));
  }
}
