import 'package:calculadora/common/constants/routes.dart';
import 'package:calculadora/widgets/calculator_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NamedRoute.initial,
      routes: {
        NamedRoute.initial:(context) => CalculatorScreen(),
      },
    );
  }
}
