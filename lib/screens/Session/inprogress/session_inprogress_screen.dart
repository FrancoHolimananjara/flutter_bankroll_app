import 'package:bankroll_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionInProgressScreen extends StatefulWidget {
  const SessionInProgressScreen({super.key});

  @override
  State<SessionInProgressScreen> createState() =>
      _SessionInProgressScreenState();
}

class _SessionInProgressScreenState extends State<SessionInProgressScreen> {
  SessionService _sessionService = SessionService();
  late Future<List<Session>> _futureSession;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureSession = _sessionService.getSession();
    loadSession();
  }

  loadSession() async {
    final result = await _sessionService.getSession();
    print('result length : ${result.length}');
    result.forEach((element) {
      print(element.place);
    });
  }

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
        ),
        FutureBuilder<List<Session>>(
          future: _sessionService.getSession(),
          builder: (((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text('${snapshot.data?.length}');
            } else if (snapshot.hasError) {
              return Text(
                "Error",
                style: TextStyle(color: Colors.red[400]),
              );
            }
            return Text('${snapshot.data}');
          })),
        )
      ],
    );
  }
}
