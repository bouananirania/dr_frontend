class Consultation {
  final String? id;
  final String patient;
  final DateTime? date;
  final String typeConsultation;
  final String? remarque;
  final List<String>? prescription;

  Consultation({
    this.id,
    required this.patient,
    this.date, // optionnelle, car gérée par le backend
    required this.typeConsultation,
    this.remarque,
    this.prescription,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['_id'] as String?,
      patient: json['patient'] as String,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : null, // gère la possibilité de null
      typeConsultation: json['typeConsultation'] as String,
      remarque: json['remarque'] as String?,
      prescription: json['prescription'] != null
          ? List<String>.from(json['prescription'] as List)
          : null, // gère la possibilité de null pour prescription
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient': patient,
      'date': date?.toIso8601String(), // conversion en chaîne de caractères
      'typeConsultation': typeConsultation,
      'remarque': remarque,
      'prescription': prescription,
    };
  }
}
