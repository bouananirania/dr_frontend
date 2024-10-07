import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/rendezvous.dart'; // Import correct du provider

class CreateAppointmentScreen extends StatefulWidget {
  final String patientId; // Ajout du paramètre patientId

  const CreateAppointmentScreen(
      {super.key,
      required this.patientId}); // Modification du constructeur pour accepter patientId

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController typeController = TextEditingController();
  final List<String> types = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _addType() {
    if (typeController.text.isNotEmpty) {
      setState(() {
        types.add(typeController.text);
        typeController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final rendezvousProvider =
        Provider.of<RendezvousProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un Rendez-vous'),
      ),
      body: Center(
        child: Container(
          width: 1316,
          height: 271,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00738C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : 'Sélectionner une date',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00738C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          selectedTime != null
                              ? selectedTime!.format(context)
                              : 'Sélectionner une heure',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: typeController,
                          decoration: InputDecoration(
                            hintText: 'Type de rendez-vous',
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: const Color(0xFF00738C),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.white),
                        onPressed: _addType,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Types: ${types.join(', ')}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Appel pour créer un rendez-vous via le Provider
                          await rendezvousProvider.createRendezvous(
                            patientId: widget
                                .patientId, // Utilisation du patientId transmis
                            date:
                                DateFormat('yyyy-MM-dd').format(selectedDate!),
                            heure: selectedTime?.format(context),
                            type: types,
                          );
                          // Naviguer ou afficher un message de succès
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Rendez-vous créé avec succès!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF00738C), // Couleur du bouton
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text('Créer'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Annuler et revenir en arrière
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF004C)
                              .withOpacity(0.8), // Couleur du bouton Annuler
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text('Annuler'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
