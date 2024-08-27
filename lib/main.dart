import 'package:flutter/material.dart';
import 'package:incubate_app/screens/auth.dart';
import 'package:incubate_app/screens/dashboard.dart';
import 'package:incubate_app/screens/register.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mAIMeal Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xffFFFAF5),
        highlightColor: const Color(0xffE15555),
        // highlightColor: const Color(0xff900055),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
      routes: {
        '/auth': (context) => const AuthScreen(),
      },
    );
  }
}
