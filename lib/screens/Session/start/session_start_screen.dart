import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionStartScreen extends StatefulWidget {
  const SessionStartScreen({super.key});

  @override
  _SessionStartScreenState createState() => _SessionStartScreenState();
}

class _SessionStartScreenState extends State<SessionStartScreen> {
  DateTime _selectedStartDateTime = DateTime.now();

  bool _inprogressSession = false;

  final Map<String, DateTime?> myDate = {
    "start": null,
    "end": null,
  };

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedStartDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedStartDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        myDate['start'] = _selectedStartDateTime;

        if (!_inprogressSession) {
          myDate['end'] = _selectedStartDateTime;
        } else {
          myDate['end'] = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour + 1,
            pickedTime.minute,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 32.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _inprogressSession = !_inprogressSession;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      !_inprogressSession
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: const Text(
                    'Mettre en cours',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () => _selectDateTime(
                      context), // Set onPressed to null if _inprogressSession is false
                  icon: Icon(myDate['start'] != null
                      ? Iconsax.edit_2
                      : Iconsax.calendar_add),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "${myDate['start'] ?? "Choisir la date de début"}",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            !_inprogressSession
                ? TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () => _selectDateTime(
                            context), // Set onPressed to null if _inprogressSession is false
                        icon: Icon(myDate['start'] != null
                            ? Iconsax.edit_2
                            : Iconsax.calendar_add),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText:
                          "${myDate['start'] ?? "Choisir la date du fin"}",
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 16.0,
            ),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.bitcoin_card),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "Choisir le montant du buyin",
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            !_inprogressSession
                ? const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.bitcoin_refresh),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Choisir le montant du buyout",
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 16.0,
            ),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.location),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "Place",
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: () {
                // if (_formKey.currentState!.validate()) {
                //   // Les validations sont passées
                //   // Vous pouvez soumettre le formulaire ici.
                //   setState(() {
                //     formData['username'] = _usernameController.text;
                //     formData['password'] = _passwordController.text;
                //   });
                //   print(formData);
                // }
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                    color: const Color(0xFF1A374D),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    _inprogressSession ? "Commencer" : "Ajouter",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
