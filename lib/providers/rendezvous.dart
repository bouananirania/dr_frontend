import 'package:flutter/material.dart';

import '../models/rendezvous.dart';
import '../services/rendezvousServices.dart'; // Assurez-vous que le chemin est correct

class RendezvousProvider with ChangeNotifier {
  final RendezvousService _rendezvousService = RendezvousService();

  List<Rendezvous> _rendezvousList = [];
  String? _errorMessage;

  List<Rendezvous> get rendezvousList => _rendezvousList;
  String? get errorMessage => _errorMessage;

  // Récupérer tous les rendez-vous
  Future<void> fetchAllRendezvous() async {
    try {
      _rendezvousList = await _rendezvousService.getAllRendezvous();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Créer un nouveau rendez-vous
  Future<void> createRendezvous({
    required String patientId,
    required String date,
    required String? heure,
    required List<String> type,
  }) async {
    try {
      final newRendezvous = await _rendezvousService.createRendezvous(
        patientId: patientId,
        date: date,
        heure: heure,
        type: type,
      );
      _rendezvousList.add(newRendezvous);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Supprimer un rendez-vous
  Future<void> deleteRendezvous(String id) async {
    try {
      await _rendezvousService.deleteRendezvous(id);
      _rendezvousList.removeWhere((rendezvous) => rendezvous.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Rechercher des rendez-vous
  Future<void> searchRendezvous(String searchTerm) async {
    try {
      _rendezvousList = await _rendezvousService.searchRendezvous(searchTerm);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Réinitialiser les erreurs
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
