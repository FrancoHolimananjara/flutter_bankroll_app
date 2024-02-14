import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionDoneScreen extends StatelessWidget {
  const SessionDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Iconsax.calendar_add,
          size: 50,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "Appuyer pour ajouter un session déjà achevé",
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        )
      ],
    );
  }
}
