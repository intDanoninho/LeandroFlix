import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 87, 88, 90), // Defina a cor de fundo desejada
      ),
      home: Home(),
    );
  }
}