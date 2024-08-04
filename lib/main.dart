import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screen/HomePage.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 251, 148, 182)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
