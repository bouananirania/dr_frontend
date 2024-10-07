import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart'; // Assurez-vous d'importer provider

import '../providers/patient.dart';
import '../widgets/customBackground.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  // Liste pour stocker les maladies
  List<String> maladies = [];
  // Contrôleurs pour les champs de saisie
  TextEditingController maladieController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController remarqueController = TextEditingController();

  String? selectedGenre; // Pour stocker le genre sélectionné

  // Liste des booléens pour les cases à cocher
  List<bool> isChecked = [];

  @override
  void dispose() {
    // Libérer les contrôleurs lors de la destruction du widget
    nomController.dispose();
    dateNaissanceController.dispose();
    adresseController.dispose();
    telephoneController.dispose();
    genreController.dispose();
    remarqueController.dispose();
    maladieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(
            selectedMenu: "Ajouter un patient",
            circleIconPath: "assets/images/ajout.svg",
            pageTitle: "/add_patient",
            child: Stack(
              children: [
                // Titre en haut à gauche
                const Positioned(
                  top: 0,
                  left: 25,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "AJOUTER UN PATIENT", // Titre en haut à gauche
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00738C),
                      ),
                    ),
                  ),
                ),

                // Formulaire en dessous
                Padding(
                  padding: const EdgeInsets.all(90.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                switchInCurve: Curves.easeInOut,
                                switchOutCurve: Curves.easeInOut,
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: selectedGenre == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              'assets/images/userm.svg',
                                              width: 150,
                                              height: 150,
                                              key: const ValueKey('userm'),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Center(
                                            child: SvgPicture.asset(
                                              'assets/images/userf.svg',
                                              width: 150,
                                              height: 150,
                                              key: const ValueKey('userf'),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Center(
                                        heightFactor: 2.20,
                                        child: selectedGenre == 'Homme'
                                            ? SvgPicture.asset(
                                                'assets/images/userm.svg',
                                                width: 150,
                                                height: 150,
                                                key: const ValueKey('userm'),
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/userf.svg',
                                                width: 150,
                                                height: 150,
                                                key: const ValueKey('userf'),
                                              ),
                                      ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 80),

                          // Colonne pour les champs de formulaire
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTitleWithInputField('NOM COMPLET',
                                    'Entrez le nom complet', nomController),
                                _buildTitleWithInputField('DATE DE NAISSANCE',
                                    'JJ/MM/AAAA', dateNaissanceController),
                                _buildTitleWithInputField('NUMÉRO DE TÉLÉPHONE',
                                    'Entrez le numéro', telephoneController),
                                _buildTitleWithInputField('ADRESSE',
                                    'Entrez l\'adresse', adresseController),
                                _buildTitleWithInputField('REMARQUE',
                                    'Entrez une remarque', remarqueController),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),

                          // Colonne pour genre et remarques
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDropdownField(
                                    'GENRE', ['Homme', 'Femme']),
                                _buildTitleWithInputFieldWithButton(
                                    'MALADIE(S)',
                                    'Entrez une maladie puis ok '),
                                const SizedBox(height: 10),
                                Column(
                                  children:
                                      List.generate(maladies.length, (index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: isChecked[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked[index] = value!;
                                              if (!value) {
                                                maladies.removeAt(index);
                                                isChecked.removeAt(index);
                                              }
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Text(maladies[index]),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Positionnement du bouton "Ajouter Patient"
          Positioned(
            bottom: 45,
            right: 90,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x00ff004c)
                    .withOpacity(0.6), // Couleur avec 30% de transparence
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                // Ajout du patient
                if (_validateInputs()) {
                  try {
                    await Provider.of<PatientProvider>(context, listen: false)
                        .addPatient(
                      nom: nomController.text,
                      dateNaissance: dateNaissanceController.text,
                      adresse: adresseController.text,
                      telephone: telephoneController.text,
                      genre:
                          selectedGenre ?? '', // Utiliser le genre sélectionné
                      maladies: maladies.join(', '),
                      remarque: remarqueController.text,
                    );

                    // Réinitialiser les contrôleurs après l'ajout
                    _resetFields();

                    // Vous pouvez aussi afficher un message de succès ici
                  } catch (e) {
                    // Gérez les erreurs ici (par exemple, afficher un message d'erreur)
                  }
                } else {
                  // Afficher un message d'erreur si les champs sont invalides
                  _showErrorDialog(
                      "Veuillez remplir tous les champs obligatoires.");
                }
              },
              child: const Text(
                'Ajouter Patient',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWithInputFieldWithButton(String title, String hintText) {
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
                    controller: maladieController,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines:
                        null, // Permet au TextField de grandir verticalement
                  ),
                ),
                const SizedBox(
                    width: 5), // Espacement entre le champ et le bouton
                ElevatedButton(
                  onPressed: () {
                    // Ajouter la maladie à la liste sans effacer le champ de saisie
                    if (maladieController.text.isNotEmpty) {
                      setState(() {
                        maladies.add(maladieController.text);
                        isChecked.add(true); // Initialisation à true
                        maladieController
                            .clear(); // Effacer le champ après l'ajout
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 05),
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

  // Méthode helper pour le dropdown genre
  Widget _buildDropdownField(String title, List<String> options) {
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedGenre,
              hint: const Text('Sélectionnez le genre'),
              icon: const Icon(Icons.arrow_drop_down),
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGenre = newValue!;
                });
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour vérifier si tous les champs obligatoires sont remplis
  bool _validateInputs() {
    return nomController.text.isNotEmpty &&
        dateNaissanceController.text.isNotEmpty &&
        telephoneController.text.isNotEmpty &&
        adresseController.text.isNotEmpty &&
        (selectedGenre != null) &&
        maladies.isNotEmpty; // Assurez-vous qu'il y a au moins une maladie
  }

  // Méthode pour réinitialiser les champs
  void _resetFields() {
    nomController.clear();
    dateNaissanceController.clear();
    adresseController.clear();
    telephoneController.clear();
    remarqueController.clear();
    maladieController.clear();
    selectedGenre = null; // Réinitialiser le genre
    maladies.clear();
    isChecked.clear(); // Réinitialiser la liste des cases à cocher
    setState(() {});
  }

  // Méthode pour afficher un message d'erreur
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
