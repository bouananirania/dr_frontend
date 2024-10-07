import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/CustomBackground.dart';

class ConsulterPatientPage extends StatelessWidget {
  ConsulterPatientPage({
    super.key,
  });
  List<String> types = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        selectedMenu: "Consultation",
        circleIconPath: "assets/images/stethoscope.svg",
        // pageTitle: ConsulterPatientPage(),
        child: Stack(
          children: [
            // Titre en haut à gauche
            const Positioned(
              top: 0,
              left: 25,
              child: Text(
                'Consulter Patient',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00738C),
                  decoration: TextDecoration.none, // Couleur du titre
                ),
              ),
            ),

            // Icone du genre et informations du patient
            Positioned(
              top: 100,
              left: 100,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'genre' == 'Homme'
                        ? 'assets/icons/userm.svg'
                        : 'assets/icons/userf.svg',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'nomComplet',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00738C),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Téléphone:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF00738C),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Adresse:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF00738C),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Champ pour le type
            const Positioned(
              top: 240,
              left: 30,
              right: 30,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Champ pour les remarques
            const Positioned(
              top: 310,
              left: 30,
              right: 30,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Remarques',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),

            // Champ pour la prescription
            const Positioned(
              top: 400,
              left: 30,
              right: 30,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Prescription',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),

            // Bouton "OK"
            Positioned(
              top: 500,
              right: 180,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour le bouton OK
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: const Color(0xFF00738C),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            // Bouton "Planifier prochain rendez-vous"
            Positioned(
              top: 500,
              right: 30,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour planifier le prochain rendez-vous
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: const Color(0xFF00738C),
                ),
                child: const Text(
                  'Planifier RDV',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
