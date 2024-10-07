import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart'; // Chemin vers ton provider
import 'dashboard_screen.dart'; // Chemin vers le tableau de bord

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0098B9),
              Color(0xFF80CBDC),
              Color(0xFFBFE5ED),
              Color(0xFFFFFFFF),
            ],
            stops: [0.0, 0.5, 0.75, 1.0],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                          labelText: 'Nom d\'utilisateur'),
                    ),
                    const SizedBox(height: 03),
                    TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(labelText: 'Mot de passe'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardPage()),
                        );
                        await Provider.of<UserProvider>(context, listen: false)
                            .login(username, password);

                        if (Provider.of<UserProvider>(context, listen: false)
                                .user !=
                            null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Échec de la connexion')),
                          );
                        }
                      },
                      child: const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ChangePasswordDialog(
                              username: _usernameController.text),
                        );
                      },
                      child: const Text(
                        'Changer le mot de passe',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => RegisterDialog(),
                        );
                      },
                      child: const Text('Inscrire',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 200),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight, // Aligner à droite
                child: SizedBox(
                  width: 800, // Ajustez la largeur ici
                  height: 600, // Ajustez la hauteur ici
                  child: SvgPicture.asset(
                    'assets/images/Group2.svg',
                    fit: BoxFit
                        .contain, // Ajuste l'image SVG à l'intérieur du conteneur
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  final String username; // Passer le nom d'utilisateur
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ChangePasswordDialog({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Changer le Mot de Passe'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _oldPasswordController,
            decoration: const InputDecoration(labelText: 'Ancien Mot de Passe'),
            obscureText: true,
          ),
          TextField(
            controller: _newPasswordController,
            decoration:
                const InputDecoration(labelText: 'Nouveau Mot de Passe'),
            obscureText: true,
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
                labelText: 'Confirmer le Nouveau Mot de Passe'),
            obscureText: true,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () async {
            String oldPassword = _oldPasswordController.text;
            String newPassword = _newPasswordController.text;
            String confirmPassword = _confirmPasswordController.text;

            await Provider.of<UserProvider>(context, listen: false)
                .changePassword(
                    username, oldPassword, newPassword, confirmPassword);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mot de passe changé avec succès')),
            );

            Navigator.of(context).pop();
          },
          child: const Text('Changer le Mot de Passe'),
        ),
      ],
    );
  }
}

class RegisterDialog extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Inscription'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Nom d\'utilisateur'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Mot de passe'),
            obscureText: true,
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration:
                const InputDecoration(labelText: 'Confirmer le Mot de Passe'),
            obscureText: true,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () async {
            String username = _usernameController.text;
            String password = _passwordController.text;
            String confirmPassword = _confirmPasswordController.text;

            await Provider.of<UserProvider>(context, listen: false)
                .inscrire(username, password, confirmPassword);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inscription réussie')),
            );

            Navigator.of(context).pop();
          },
          child: const Text('Inscrire'),
        ),
      ],
    );
  }
}
