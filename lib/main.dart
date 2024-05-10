import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loadFonts();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: LoginPage());
  }
}

Future<void> loadFonts() async {
  await Future.wait([
    FontLoader('Poppins-Regular').load(),
    FontLoader('Poppins-Bold').load(),
    FontLoader('Poppins-Light').load(),
    FontLoader('Poppins-SemiBold').load(),
  ]);
}
