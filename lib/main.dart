import 'package:devsync/backend.dart';
import 'package:devsync/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Backend backend = Backend();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevSync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
