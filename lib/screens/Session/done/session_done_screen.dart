import 'package:bankroll_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionDoneScreen extends StatefulWidget {
  const SessionDoneScreen({super.key});

  @override
  State<SessionDoneScreen> createState() => _SessionDoneScreenState();
}

class _SessionDoneScreenState extends State<SessionDoneScreen> {
  SessionService _sessionService = SessionService();
  late Future<List<Session>> _futureSession;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureSession = _sessionService.getSession(false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Session>>(
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
              return ListTile(
                title: Text(session.place),
              );
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
      },
    );
  }
}
