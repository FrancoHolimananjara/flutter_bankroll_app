import 'package:bankroll_app/providers/user_provider.dart';
import 'package:bankroll_app/screens/authentication/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MyApp(),
  ));
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
      home: RegisterScreen(),
    );
  }
}
