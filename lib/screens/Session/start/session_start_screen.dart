import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SessionStartScreen extends StatefulWidget {
  const SessionStartScreen({super.key});

  @override
  _SessionStartScreenState createState() => _SessionStartScreenState();
}

class _SessionStartScreenState extends State<SessionStartScreen> {
  TextEditingController _buyinController = TextEditingController();
  TextEditingController _buyoutController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedStartDateTime = DateTime.now();
  DateTime _selectedEndDateTime = DateTime.now();

  bool _inprogressSession = false;

  final Map<String, DateTime?> myDate = {
    "start": null,
    "end": null,
  };

  final Map<String, dynamic> formData = {
    // "start": null,
    // "end": null,
    // "inprogress": false,
    // "buyin": 0,
    // "buyout": 0,
    // "place": null,
  };

  Future<void> _selectDateTimeStart(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
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
              TextFormField(
                readOnly: true,
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
                  labelText: "${myDate['start'] ?? "Choisir la date de début"}",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              !_inprogressSession
                  ? TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () => _selectDateTimeEnd(
                              context), // Set onPressed to null if _inprogressSession is false
                          icon: Icon(myDate['end'] != null
                              ? Iconsax.edit_2
                              : Iconsax.calendar_add),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText:
                            "${myDate['end'] ?? "Choisir la date du fin"}",
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                      formData['start'] = myDate['start'];
                      formData['end'] =
                          !_inprogressSession ? myDate['end'] : myDate['start'];
                      formData['inprogress'] = _inprogressSession;
                      formData['buyin'] = int.parse(_buyinController.text);
                      formData['buyout'] = !_inprogressSession
                          ? int.parse(_buyoutController.text)
                          : 0;
                      formData['place'] = _placeController.text;
                    });
                    print(formData);
                  }
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
      ),
    );
  }
}
