import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/patient.dart'; // Assurez-vous que le chemin est correct

class PatientService {
  final String apiUrl =
      'http://localhost:3000/patient'; // Modifiez selon votre configuration

  // Ajouter un patient
  Future<Patient> addPatient({
    required String nom,
    required String dateNaissance,
    required String adresse,
    required String telephone,
    required String genre,
    required String maladies,
    required String remarque,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom': nom,
        'dateNaissance': dateNaissance,
        'adresse': adresse,
        'telephone': telephone,
        'genre': genre,
        'maladies': maladies,
        'remarque': remarque,
      }),
    );

    if (response.statusCode == 201) {
      return Patient.fromJson(jsonDecode(response.body)['patient']);
    } else {
      throw Exception('Erreur lors de l\'ajout du patient');
    }
  }

  // Supprimer un patient
  Future<void> deletePatient(String id) async {
    final response = await http.post(
      Uri.parse('$apiUrl/delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression du patient');
    }
  }

  // Mettre à jour un patient
  Future<Patient> updatePatient({
    required String id,
    required String nom,
    required String dateNaissance,
    required String adresse,
    required String telephone,
    required String maladies,
    required String remarque,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'nom': nom,
        'dateNaissance': dateNaissance,
        'adresse': adresse,
        'telephone': telephone,
        'maladies': maladies,
        'remarque': remarque,
      }),
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body)['user']);
    } else {
      throw Exception('Erreur lors de la mise à jour du patient');
    }
  }

  // Obtenir tous les patients
  Future<List<Patient>> getAllPatients() async {
    final response = await http.get(Uri.parse('$apiUrl/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['patients'];
      return data.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des patients');
    }
  }

  // Obtenir les détails d'un patient
  Future<PatientDetails> getPatientData(String id) async {
    final response = await http.post(
      Uri.parse('$apiUrl/patientData'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PatientDetails.fromJson(data);
    } else {
      throw Exception('Erreur lors de la récupération des détails du patient');
    }
  }

  // Rechercher des patients
  Future<List<Patient>> searchPatients(String searchTerm) async {
    final response = await http.post(
      Uri.parse('$apiUrl/searchPatients'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'searchTerm': searchTerm}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['patients'];
      return data.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors de la recherche de patients');
    }
  }
}
