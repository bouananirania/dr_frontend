import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/CustomBackground.dart';

class ConsulterPatientPage extends StatefulWidget {
  ConsulterPatientPage({super.key});

  @override
  _ConsulterPatientPageState createState() => _ConsulterPatientPageState();
}

class _ConsulterPatientPageState extends State<ConsulterPatientPage> {
  List<String> types = [];
  List<String> pres = [];
  List<bool> isCheckedtype = [];
  List<bool> isCheckedpres = [];
  TextEditingController remarqueController = TextEditingController();
  TextEditingController presController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  @override
  void dispose() {
    // Libérer les contrôleurs lors de la destruction du widget
    remarqueController.dispose();
    typeController.dispose();
    presController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        selectedMenu: "Consultation",
        circleIconPath: "assets/images/stethoscope.svg",
        pageTitle: "Consultation",
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre en haut à gauche
                  const Text(
                    'Consulter Patient',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00738C),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  // Icone du genre et informations du patient
                  Positioned(
                    left: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/userm.svg',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(width: 80),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nom Complet :',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00738C),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Téléphone:',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00738C),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Adresse:',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00738C),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Champs "Type", "Remarques", et "Prescription" alignés horizontalement
                  Row(
                    children: [
                      // Champ pour le type
                      Expanded(
                        child: _buildTitleWithInputFieldWithButton(
                          'Type',
                          'Entrez le type',
                          typeController,
                          types,
                          isCheckedtype,
                        ),
                      ),

                      const SizedBox(width: 20), // Espacement entre les champs

                      // Champ pour la prescription
                      Expanded(
                        child: _buildTitleWithInputFieldWithButton(
                          'Prescription',
                          'Entrez la prescription',
                          presController,
                          pres,
                          isCheckedpres,
                        ),
                      ),

                      const SizedBox(width: 20), // Espacement entre les champs

                      Expanded(
                        child: _buildTitleWithInputField(
                          'Remarques',
                          'Entrez vos remarques',
                          remarqueController,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Affichage des types ajoutés
                  Column(
                    children: List.generate(types.length, (index) {
                      return Row(
                        children: [
                          Checkbox(
                            value: isCheckedtype[index],
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedtype[index] = value!;
                                if (!value) {
                                  types.removeAt(index);
                                  isCheckedtype.removeAt(index);
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Text(types[index]),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Affichage des prescriptions ajoutées
                  Column(
                    children: List.generate(pres.length, (index) {
                      return Row(
                        children: [
                          Checkbox(
                            value: isCheckedpres[index],
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedpres[index] = value!;
                                if (!value) {
                                  pres.removeAt(index);
                                  isCheckedpres.removeAt(index);
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Text(pres[index]),
                          ),
                        ],
                      );
                    }),
                  ),

                  const SizedBox(height: 200),

                  // Boutons "OK" et "Planifier prochain rendez-vous"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Action pour le bouton OK
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: const Color(0xFF00738C),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {
                          // Action pour planifier le prochain rendez-vous
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          backgroundColor: const Color(0xFF00738C),
                        ),
                        child: const Text(
                          'Planifier RDV',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWithInputFieldWithButton(
      String title,
      String hintText,
      TextEditingController contr,
      List<String> itemList,
      List<bool> checkedList) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF00738C),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: contr,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    // Ajouter le type ou la prescription à la liste sans effacer le champ de saisie
                    if (contr.text.isNotEmpty) {
                      setState(() {
                        if (title == 'Type') {
                          itemList.add(contr.text);
                          checkedList.add(true); // Initialisation à true
                        } else if (title == 'Prescription') {
                          itemList.add(contr.text);
                          checkedList.add(true); // Initialisation à true
                        }
                        contr.clear(); // Effacer le champ après l'ajout
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Méthode helper pour créer un champ avec titre
Widget _buildTitleWithInputField(
    String title, String hintText, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF00738C),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 05),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 05),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
            minLines: 1,
            maxLines: null, // Permet au TextField de grandir verticalement
          ),
        ),
      ],
    ),
  );
}
