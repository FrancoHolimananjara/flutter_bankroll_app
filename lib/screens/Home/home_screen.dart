import 'dart:math';

import 'package:bankroll_app/providers/theme_provider.dart';
import 'package:bankroll_app/providers/user_provider.dart';
import 'package:bankroll_app/services/bank_service.dart';
import 'package:bankroll_app/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BankrollService _bankrollService = BankrollService();
  final TransactionService _transactionService = TransactionService();
  late Future<Bankroll> _bankroll;

  @override
  void initState() {
    super.initState();
    _bankrollService.getBankroll();
    _transactionService.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.username),
              accountEmail: Text(user.email),
            ),
            const Text("Home"),
            const Text("Home"),
            const Spacer(),
            FilledButton(
              onPressed: () {
                setState(() {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Provider.of<ThemeProvider>(context).isDarkMode
                      ? const Color(0xFF642CFF)
                      : Theme.of(context).colorScheme.tertiary,
                ),
              ),
              child: Icon(Iconsax.moon,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 57, 57, 57)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Hi,${user.username}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Bienvenue",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.setting),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width + 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xFF282828),
                      Color(0xFF282828),
                      Color(0xFF282828),
                      Color.fromARGB(255, 74, 74, 74)
                    ], transform: GradientRotation(pi / 5)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Votre balance actuelle",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        FutureBuilder<Bankroll>(
                            future: _bankrollService.getBankroll(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    "Error ${snapshot.error.toString()}",
                                    style: TextStyle(color: Colors.red[400]),
                                  ),
                                );
                              } else {
                                final data = snapshot.data;
                                var d = (data!.bank / 1000).abs();
                                return Text(
                                  '$d K Ar',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Déposer
                                _actionInCard(
                                  "images/u_sync.svg",
                                  "Déposer",
                                ),
                                // Transférer
                                _actionInCard(
                                  "images/u_exchange.svg",
                                  "Transférer",
                                ),
                                // Rétirer
                                _actionInCard(
                                  "images/u_export.svg",
                                  "Rétirer",
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
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Déposer
                    _quickInfoOnTransaction(
                        "Dépot", const Color.fromARGB(255, 74, 74, 74)),
                    // Transférer
                    _quickInfoOnTransaction(
                        "Transfert", const Color(0xFF282828)),
                    // Rétirer
                    _quickInfoOnTransaction(
                        "Retrait", const Color.fromARGB(255, 74, 74, 74)),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transactions récentes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Voir Tous",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: FutureBuilder<List<Transaction>>(
                future: _transactionService.getAllTransactions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error ${snapshot.error.toString()}",
                        style: TextStyle(color: Colors.red[400]),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final transaction = snapshot.data![index];
                      return _transactionTile(transaction);
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionInCard(String svgPath, String text) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          SvgPicture.asset(
            svgPath,
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _quickInfoOnTransaction(String text, Color color) {
    return Container(
      width: 95,
      height: 96,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const Text(
              "5",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/u_check-circle.svg",
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/u_minus-circle.svg",
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionTile(Transaction transaction) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Theme.of(context).colorScheme.tertiary
                : const Color(0xFFF2F2F2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 5, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF282828),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.icon,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      transaction.action,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${(transaction.amount / 1000)} K Ar",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Il y a ${DateTime.now().difference(transaction.date).inMinutes} min",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
