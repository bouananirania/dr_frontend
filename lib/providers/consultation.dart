import 'package:flutter/material.dart';

import '../models/consultation.dart';
import '../services/consultationServices.dart';

class ConsultationProvider with ChangeNotifier {
  final ConsultationService _consultationService = ConsultationService();
  final List<Consultation> _consultations = [];
  bool _loading = false;

  List<Consultation> get consultations => _consultations;
  bool get loading => _loading;

  // Ajouter une consultation
  Future<void> addConsultation({
    required String idPatient,
    required String typeConsultation,
    required List<String> prescriptions,
    String? remarque,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      Consultation newConsultation = await _consultationService.addConsultation(
        idPatient: idPatient,
        typeConsultation: typeConsultation,
        prescriptions: prescriptions,
        remarque: remarque,
      );
      _consultations.add(newConsultation);
    } catch (e) {
      print('Erreur lors de l\'ajout de la consultation : $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
