import 'package:bankroll_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                _header(),
                // Form
                _formUi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        SvgPicture.asset("images/logo.svg"),
        const SizedBox(
          height: 16,
        ),
        Text(
          "De retour? Bienvenue,",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "To add the geolocator to your Flutter application read the install instructions. Below are some Android and iOS specifics that are required for the geolocator to work correctly.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        )
      ],
    );
  }

  Widget _formUi() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              validator: _validateUsername,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.user),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                labelText: 'Username',
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: !showPassword,
              validator: _validatePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon:
                        Icon(!showPassword ? Iconsax.eye : Iconsax.eye_slash)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                labelText: "Password",
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),

            // Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password ?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )),
              ],
            ),

            const SizedBox(
              height: 16,
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
                  onSignIn();
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
                    "Se connecter",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Sign up Button
          ],
        ),
      ),
    );
  }
}
