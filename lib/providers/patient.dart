import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../services/patientServices.dart';

class PatientProvider with ChangeNotifier {
  final PatientService _patientService = PatientService();

  List<Patient> _patients = [];
  Patient? _currentPatient;
  String? _errorMessage;

  List<Patient> get patients => _patients;
  Patient? get currentPatient => _currentPatient;
  String? get errorMessage => _errorMessage;

  // Récupérer tous les patients
  Future<void> fetchAllPatients() async {
    try {
      _patients = await _patientService.getAllPatients();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Ajouter un nouveau patient
  Future<void> addPatient({
    required String nom,
    required String dateNaissance,
    required String adresse,
    required String telephone,
    required String genre,
    required String maladies,
    required String remarque,
  }) async {
    try {
      final newPatient = await _patientService.addPatient(
        nom: nom,
        dateNaissance: dateNaissance,
        adresse: adresse,
        telephone: telephone,
        genre: genre,
        maladies: maladies,
        remarque: remarque,
      );
      _patients.add(newPatient);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Supprimer un patient
  Future<void> deletePatient(String id) async {
    try {
      await _patientService.deletePatient(id);
      _patients.removeWhere((patient) => patient.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Mettre à jour un patient
  Future<void> updatePatient({
    required String id,
    required String nom,
    required String dateNaissance,
    required String adresse,
    required String telephone,
    required String maladies,
    required String remarque,
  }) async {
    try {
      final updatedPatient = await _patientService.updatePatient(
        id: id,
        nom: nom,
        dateNaissance: dateNaissance,
        adresse: adresse,
        telephone: telephone,
        maladies: maladies,
        remarque: remarque,
      );
      final index = _patients.indexWhere((patient) => patient.id == id);
      if (index != -1) {
        _patients[index] = updatedPatient;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Obtenir les détails d'un patient
  Future<void> fetchPatientData(String id) async {
    try {
      final patientDetails = await _patientService.getPatientData(id);
      _currentPatient = patientDetails.patient;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Rechercher des patients
  Future<void> searchPatients(String searchTerm) async {
    try {
      _patients = await _patientService.searchPatients(searchTerm);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Réinitialiser l'erreur
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
