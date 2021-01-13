import 'package:flutter/material.dart';
import 'package:housie/onloadscreen.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppstate createState() => _MyAppstate();
}

class _MyAppstate extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity, backgroundColor: Color(0xFF2e9eba)),
      home: onloadscreen(),
    );
  }
}

