import 'package:bankroll_app/screens/Session/done/session_done_screen.dart';
import 'package:bankroll_app/screens/Session/inprogress/session_inprogress_screen.dart';
import 'package:bankroll_app/screens/Session/start/session_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Session",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A374D),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        dividerColor: Colors.transparent,
                        labelColor: Theme.of(context).colorScheme.primary,
                        tabs: const [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.add_circle),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Nouvel",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.clock),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "En cours",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.main_component),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Achevés",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            SessionStartScreen(),
                            SessionInProgressScreen(),
                            SessionDoneScreen(),
                          ],
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
    );
  }
}
