import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 15),
            child: Column(
              children: [
                // Logo, Title and Subtitle
                const Column(
                  children: [
                    Icon(
                      Iconsax.airdrop,
                      size: 100,
                    ),
                    Text(
                      "Welcome back,",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Discover your bankroll evolution by game.",
                    )
                  ],
                ),

                // Form
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.direct_right),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.password_check),
                            suffixIcon: Icon(Iconsax.eye),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: "Password",
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),

                        // Forgot password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot password ?",
                                )),
                          ],
                        ),

                        const SizedBox(
                          height: 32,
                        ),

                        // Signin Button
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width / 7,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1A374D),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),

                        // Sign up Button
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width / 7,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Color(0xFF1A374D),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
