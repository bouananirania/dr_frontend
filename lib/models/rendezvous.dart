class Rendezvous {
  final String? id;
  final String patientId;
  final DateTime date;
  final String? heure;
  final List<String> type;

  Rendezvous({
    this.id,
    required this.patientId,
    required this.date,
    this.heure,
    required this.type,
  });

  factory Rendezvous.fromJson(Map<String, dynamic> json) {
    return Rendezvous(
      id: json['_id'] as String?, // Ajout du cast explicite à String?
      patientId: json['patient'] as String, // Ajout du cast explicite à String
      date: DateTime.parse(
          json['date'] as String), // Assurer que c'est une String
      heure: json['heure'] as String?, // Peut-être null, donc cast explicite
      type: List<String>.from(
          json['type'] as List<dynamic>), // Cast dynamique pour la liste
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient': patientId,
      'date': date.toIso8601String(),
      'heure': heure,
      'type': type,
    };
  }
}
