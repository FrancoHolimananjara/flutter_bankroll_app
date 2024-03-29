import 'package:bankroll_app/screens/Home/home_screen.dart';
import 'package:bankroll_app/screens/Profile/profile_screen.dart';
import 'package:bankroll_app/screens/Session/session_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: Theme.of(context).colorScheme.tertiary,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Accueil'),
          NavigationDestination(
              icon: Icon(Iconsax.calendar_2), label: 'Sessions'),
          NavigationDestination(icon: Icon(Iconsax.chart_3), label: 'Stats'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          const SessionScreen(),
          Container(color: Colors.green),
          const ProfileScreen(),
        ],
      ),
    );
  }
}
