import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/consultation.dart';

class ConsultationService {
  final String apiUrl = 'http://localhost:3000/consultation';

  // Ajouter une consultation
  Future<Consultation> addConsultation({
    required String idPatient,
    required String typeConsultation,
    required List<String> prescriptions,
    String? remarque,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/creat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': idPatient,
        'typeConsultation': typeConsultation,
        'prescriptions': prescriptions,
        'remarque': remarque,
      }),
    );

    if (response.statusCode == 201) {
      return Consultation.fromJson(jsonDecode(response.body)['consultation']);
    } else {
      throw Exception('Erreur lors de l\'ajout de la consultation');
    }
  }
}
