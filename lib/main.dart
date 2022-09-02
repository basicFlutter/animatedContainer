import 'package:animation_container/security_animation.dart';
import 'package:flutter/material.dart';

void main() {
  Paint.enableDithering = true;
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home:  SecurityAnimation(),
      debugShowCheckedModeBanner: false,
    );
  }
}