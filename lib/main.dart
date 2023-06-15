import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twilio/providers/home_provider.dart';
import 'package:twilio/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(),
        child: const HomeScreen(),
      ),
    );
  }
}
