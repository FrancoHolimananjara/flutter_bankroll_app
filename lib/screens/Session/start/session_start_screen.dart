import 'package:bankroll_app/providers/theme_provider.dart';
import 'package:bankroll_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SessionStartScreen extends StatefulWidget {
  const SessionStartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SessionStartScreenState createState() => _SessionStartScreenState();
}

class _SessionStartScreenState extends State<SessionStartScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _buyinController = TextEditingController();
  final TextEditingController _buyoutController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final SessionService _sessionService = SessionService();

  DateTime _selectedStartDateTime = DateTime.now();
  DateTime _selectedEndDateTime = DateTime.now();

  bool _inprogressSession = false;

  final Map<String, DateTime?> myDate = {
    "start": null,
    "end": null,
  };

  final Map<String, dynamic> formData = {};

  Future<void> _selectDateTimeStart(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
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
          _startDateController.text = _selectedStartDateTime.toString();
        });
        myDate['start'] = _selectedStartDateTime;
      }
    }
  }

  Future<void> _selectDateTimeEnd(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedEndDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedEndDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _endDateController.text = _selectedEndDateTime.toString();
        });

        if (!_inprogressSession) {
          myDate['end'] = _selectedEndDateTime;
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
  void dispose() {
    _buyinController.dispose();
    _buyoutController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  String? _validateBuyin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Buyin invalid';
    }
    // Ajoutez d'autres validations si nécessaire, comme la validation du format d'email.
    return null;
  }

  String? _validateBuyout(String? value) {
    if (value == null || value.isEmpty) {
      return 'Buyout invalid';
    }
    // Ajoutez d'autres validations si nécessaire, comme la validation du format d'email.
    return null;
  }

  String? _validatePlace(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the place';
    }
    // Ajoutez d'autres validations si nécessaire, comme la longueur minimale du mot de passe.
    return null;
  }

  void onAddNewSession() {
    _sessionService.addNewSession(context: context, formData: formData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _inprogressSession = !_inprogressSession;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      !_inprogressSession
                          ? Theme.of(context).colorScheme.background
                          : const Color(0xFF642CFF),
                    ),
                  ),
                  child: Text(
                    _inprogressSession ? "En cours" : "Mettre en cours ?",
                    style: TextStyle(
                      color: _inprogressSession
                          ? Colors.grey.shade200
                          : Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _inprogressSession ? 0 : 16.0,
            ),
            !_inprogressSession
                ? TextFormField(
                    readOnly: true,
                    controller: _startDateController,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () => _selectDateTimeStart(
                            context), // Set onPressed to null if _inprogressSession is false
                        icon: Icon(myDate['start'] != null
                            ? Iconsax.edit_2
                            : Iconsax.calendar_add),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Choisir la date de début",
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 16,
            ),
            !_inprogressSession
                ? TextFormField(
                    readOnly: true,
                    controller: _endDateController,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () => _selectDateTimeEnd(
                            context), // Set onPressed to null if _inprogressSession is false
                        icon: Icon(myDate['end'] != null
                            ? Iconsax.edit_2
                            : Iconsax.calendar_add),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Choisir la date du fin",
                    ),
                  )
                : Container(),
            SizedBox(
              height: _inprogressSession ? 0 : 16.0,
            ),
            TextFormField(
              controller: _buyinController,
              validator: _validateBuyin,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.bitcoin_card),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "Entrer le montant du buyin",
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            !_inprogressSession
                ? TextFormField(
                    controller: _buyoutController,
                    validator: _validateBuyout,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.bitcoin_refresh),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Entrer le montant du buyout",
                    ),
                  )
                : Container(),
            SizedBox(
              height: _inprogressSession ? 0 : 16.0,
            ),
            TextFormField(
              controller: _placeController,
              validator: _validatePlace,
              decoration: const InputDecoration(
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
                if (_formKey.currentState!.validate()) {
                  // Les validations sont passées
                  // Vous pouvez soumettre le formulaire ici.
                  setState(() {
                    formData['start'] = _inprogressSession
                        ? DateTime.now().toUtc().toString()
                        : myDate['start']?.toUtc().toString();
                    formData['end'] =
                        _inprogressSession ? null : myDate['end'].toString();
                    formData['inprogress'] = _inprogressSession;
                    formData['buyin'] = int.parse(_buyinController.text);
                    formData['buyout'] = !_inprogressSession
                        ? int.parse(_buyoutController.text)
                        : 0;
                    formData['place'] = _placeController.text;
                  });
                  onAddNewSession();
                  setState(() {
                    _buyinController.clear();
                    _buyoutController.clear();
                    _placeController.clear();
                    _endDateController.clear();
                    _startDateController.clear();
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width / 7,
                decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? const Color(0xFF642CFF)
                        : const Color(0xFF282828),
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
