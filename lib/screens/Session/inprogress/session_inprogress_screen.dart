import 'package:bankroll_app/services/session_service.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Session>>(
      future: _sessionService.getSession(),
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                final session = snapshot.data![index];
                return ListTile(
                  title: Text(session.place),
                );
              }));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error ${snapshot.error.toString()}",
              style: TextStyle(color: Colors.red[400]),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     // Icon(
    //     //   Iconsax.programming_arrow,
    //     //   size: 50,
    //     //   color: Theme.of(context).colorScheme.tertiary,
    //     // ),
    //     // const SizedBox(
    //     //   height: 8.0,
    //     // ),
    //     // Text(
    //     //   "Appuyer pour ajouter et lancer un nouvel session",
    //     //   style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
    //     // ),

    //   ],
    // );
  }
}
