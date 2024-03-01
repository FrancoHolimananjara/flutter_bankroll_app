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
              Text(
                "Mes séssions",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              width: 3,
                            ),
                          ),
                        ),
                        dividerColor: Theme.of(context).colorScheme.background,
                        labelColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        tabs: const [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Iconsax.add_circle),
                                SizedBox(
                                  width: 5,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Iconsax.clock),
                                SizedBox(
                                  width: 5,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Iconsax.main_component),
                                SizedBox(
                                  width: 5,
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
