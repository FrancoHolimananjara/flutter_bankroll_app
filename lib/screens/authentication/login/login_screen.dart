import 'package:bankroll_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  bool showPassword = false;
  final formData = {"username": "", "password": ""};

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Ajoutez d'autres validations si nécessaire, comme la validation du format d'email.
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Ajoutez d'autres validations si nécessaire, comme la longueur minimale du mot de passe.
    return null;
  }

  void onSignIn() {
    _authService.login(context: context, formData: formData);
  }

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
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          validator: _validateUsername,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Username',
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: showPassword,
                          validator: _validatePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: Icon(showPassword
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash)),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: const OutlineInputBorder(
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
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Les validations sont passées
                              // Vous pouvez soumettre le formulaire ici.
                              setState(() {
                                formData['username'] = _usernameController.text;
                                formData['password'] = _passwordController.text;
                              });
                              print(formData);
                              onSignIn();
                            }
                          },
                          child: Container(
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
