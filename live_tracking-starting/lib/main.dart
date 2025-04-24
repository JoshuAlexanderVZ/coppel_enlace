import 'package:flutter/material.dart';
import 'package:live_tracking/constants.dart';
import "package:live_tracking/logging.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Flutter Way - Google Map Live Tracking',
      theme: ThemeData(
        fontFamily: "CircularStd",
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: Logging(),
      debugShowCheckedModeBanner: false,
    );
  }
}
