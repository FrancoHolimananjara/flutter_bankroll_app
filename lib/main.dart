import 'package:bankroll_app/utils/navigation_menu.dart';
import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Biennale",
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF1A374D),
            secondary: Color(0xFF406882),
            tertiary: Color(0xFF6998AB),
          )),
      home: NavigationMenu(),
    );
  }
}
