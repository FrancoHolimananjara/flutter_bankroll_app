import 'package:bankroll_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  bool showPassword = false;
  final Map<String, dynamic> formData = {
    "username": "",
    "email": "",
    "password": ""
  };

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
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

  String? _validateEmail(String? value) {
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

  void onRegister() {
    _authService.register(context: context, formData: formData);
  }

  // void _modalBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) => DraggableScrollableSheet(
  //       expand: false,
  //       initialChildSize: 0.4,
  //       maxChildSize: 0.9,
  //       minChildSize: 0.20,
  //       builder: (context, scrollController) => SingleChildScrollView(
  //         controller: scrollController,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 15),
  //           child: Column(
  //             children: [
  //               const SizedBox(
  //                 height: 5,
  //               ),
  //               Container(
  //                 width: 40,
  //                 height: 4,
  //                 decoration: const BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(5)),
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 42,
  //               ),
  //               const Text(
  //                 "OTP",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  //               ),
  //               const SizedBox(
  //                 height: 16,
  //               ),
  //               const Text(
  //                 "To add the geolocator to your Flutter application read the useremail@gmail.com instructions. ",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(),
  //               ),
  //               SizedBox(
  //                 height: 32,
  //               ),
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                     border: OutlineInputBorder(), label: Text("Hello")),
  //               ),
  //               const SizedBox(
  //                 height: 16,
  //               ),
  //               GestureDetector(
  //                 onTap: () {},
  //                 child: Container(
  //                   width: double.infinity,
  //                   height: MediaQuery.of(context).size.width / 7,
  //                   decoration: BoxDecoration(
  //                       color: const Color(0xFF282828),
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: const Center(
  //                     child: Text(
  //                       "Verifier",
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                Column(
                  children: [
                    SvgPicture.asset("images/logo.svg"),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Bienvenue,",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "To add the geolocator to your Flutter application read the install instructions. Below are some Android and iOS specifics that are required for the geolocator to work correctly.",
                      textAlign: TextAlign.center,
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
                          controller: _emailController,
                          validator: _validateEmail,
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
                                icon: Icon(!showPassword
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
                          height: 32,
                        ),

                        // Create account Button
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Les validations sont passées
                              // Vous pouvez soumettre le formulaire ici.
                              setState(() {
                                formData['username'] = _usernameController.text;
                                formData['email'] = _emailController.text;
                                formData['password'] = _passwordController.text;
                              });
                              print(formData);
                              onRegister();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width / 7,
                            decoration: BoxDecoration(
                                color: const Color(0xFF282828),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Créer",
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

                        // Sign in Button
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
