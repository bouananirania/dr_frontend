import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/rendezvous.dart'; // Modèle à définir

class RendezvousService {
  final String apiUrl =
      'http://localhost:3000/rendezvous'; // Modifiez l'URL selon votre configuration

  // Créer un rendez-vous
  Future<Rendezvous> createRendezvous({
    required String patientId,
    required String date,
    required String? heure,
    required List<String> type,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'patient': patientId,
        'date': date,
        'heure': heure,
        'type': type,
      }),
    );

    if (response.statusCode == 201) {
      return Rendezvous.fromJson(jsonDecode(response.body)['rendervous']);
    } else {
      throw Exception('Erreur lors de la création du rendez-vous');
    }
  }

  // Obtenir tous les rendez-vous
  Future<List<Rendezvous>> getAllRendezvous() async {
    final response = await http.get(Uri.parse('$apiUrl/getAll'));

    if (response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body)['rendezvous'];
      return data.map((json) => Rendezvous.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des rendez-vous');
    }
  }

  // Supprimer un rendez-vous
  Future<void> deleteRendezvous(String id) async {
    final response = await http.post(
      Uri.parse('$apiUrl/deletOne'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression du rendez-vous');
    }
  }

  // Rechercher des rendez-vous
  Future<List<Rendezvous>> searchRendezvous(String searchTerm) async {
    final response = await http.get(
      Uri.parse('$apiUrl/search?searchTerm=$searchTerm'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['rendezvous'];
      return data.map((json) => Rendezvous.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors de la recherche des rendez-vous');
    }
  }
}
