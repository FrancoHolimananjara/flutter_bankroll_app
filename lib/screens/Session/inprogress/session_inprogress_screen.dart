import 'package:bankroll_app/providers/theme_provider.dart';
import 'package:bankroll_app/services/session_service.dart';
import 'package:bankroll_app/utils/differenceBetweenDate.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SessionInProgressScreen extends StatefulWidget {
  const SessionInProgressScreen({super.key});

  @override
  State<SessionInProgressScreen> createState() =>
      _SessionInProgressScreenState();
}

class _SessionInProgressScreenState extends State<SessionInProgressScreen> {
  final SessionService _sessionService = SessionService();
  late Future<List<Session>> _futureSession;

  @override
  void initState() {
    super.initState();
    _futureSession = _sessionService.getSession(true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: FutureBuilder<List<Session>>(
        future: _futureSession,
        builder: (context, AsyncSnapshot<List<Session>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final session = snapshot.data![index];
                return _sessionTile(session);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error ${snapshot.error.toString()}",
                style: TextStyle(color: Colors.red[400]),
              ),
            );
          } else {
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _sessionTile(Session session) {
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
                        Icons.account_tree_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.place,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Cave: ${(session.buyin / 1000).abs()}K Ar",
                        ),
                      ],
                    ),
                  ],
                ),
                Text(diffBetweenDate(true, session.start, DateTime.now()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
