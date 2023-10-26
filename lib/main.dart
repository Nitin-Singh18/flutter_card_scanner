import 'package:card_scanner/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Scanner',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomeView(),
    );
  }
}
