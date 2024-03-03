import 'package:bankroll_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerificationScreen extends StatefulWidget {
  String userId, email;

  OtpVerificationScreen({super.key, required this.userId, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  AuthService _authService = AuthService();
  late String otp;

  void verifyOtpCode(String id, String theOpt) {
    _authService.verifyOtp(context: context, id: id, otp: theOpt);
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
                _header(widget.email),
                // Form
                _otpFormUi(widget.userId)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(String email) {
    return Column(
      children: [
        SvgPicture.asset("images/forOtp.svg"),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Vérification par otp",
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
          "To add the geolocator to your Flutter application read the $email instructions. ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        )
      ],
    );
  }

  Widget _otpFormUi(String id) {
    Color accentPurpleColor = Color(0xFF6A53A1);
    Color accentPinkColor = Color(0xFFF99BBD);
    Color accentDarkGreenColor = Color(0xFF115C49);
    Color accentYellowColor = Color(0xFFFFB612);
    Color accentOrangeColor = Color(0xFFEA7A3B);

    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.headline3?.copyWith(color: color);
    }

    var otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];
    return Column(
      children: [
        OtpTextField(
          numberOfFields: 6,
          borderColor: accentPurpleColor,
          focusedBorderColor: accentPurpleColor,
          styles: otpTextStyles,
          showFieldAsBox: false,
          borderWidth: 4.0,
          autoFocus: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here if necessary
          },

          //runs when every textfield is filled
          onSubmit: (String verificationCode) {
            setState(() {
              otp = verificationCode;
            });
            verifyOtpCode(id, otp);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       title: Text("Verification Code"),
            //       content: Text('Code entered is $verificationCode'),
            //     );
            //   },
            // );
          }, // end onSubmit
        ),
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 7,
            decoration: BoxDecoration(
                color: const Color(0xFF282828),
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                "Vérifier",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
