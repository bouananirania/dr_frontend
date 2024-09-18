import 'consultation.dart';

class Patient {
  final String id;
  final String nom;
  final DateTime dateNaissance;
  final String adresse;
  final String telephone;
  final String genre;
  final List<String> maladies;
  final String? remarque;

  Patient({
    required this.id,
    required this.nom,
    required this.dateNaissance,
    required this.adresse,
    required this.telephone,
    required this.genre,
    required this.maladies,
    this.remarque,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'] as String,
      nom: json['nom'] as String,
      dateNaissance: DateTime.parse(json['dateNaissance'] as String),
      adresse: json['adresse'] as String,
      telephone: json['telephone'] as String,
      genre: json['genre'] as String,
      maladies: List<String>.from(json['maladies'] as List<dynamic>),
      remarque: json['remarque'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': nom,
      'dateNaissance': dateNaissance.toIso8601String(),
      'adresse': adresse,
      'telephone': telephone,
      'genre': genre,
      'maladies': maladies,
      'remarque': remarque,
    };
  }
}

class PatientDetails {
  final Patient patient;
  final List<Consultation> prescriptions;
  final List<Consultation> historique;

  PatientDetails({
    required this.patient,
    required this.prescriptions,
    required this.historique,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      patient: Patient.fromJson(json['patient']),
      prescriptions: (json['prescriptions'] as List)
          .map((e) => Consultation.fromJson(e))
          .toList(),
      historique: (json['historique'] as List)
          .map((e) => Consultation.fromJson(e))
          .toList(),
    );
  }
}
