import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionStartScreen extends StatelessWidget {
  const SessionStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Iconsax.programming_arrow,
          size: 50,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "Appuyer pour ajouter et lancer un nouvel session",
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        )
      ],
    );
  }
}
