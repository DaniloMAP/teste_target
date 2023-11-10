import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'next_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _launchURL() async {
    const url = 'https://www.google.com.br';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool _isPasswordValid(String password) {
    return RegExp(r'^[a-zA-Z0-9]{2,}$').hasMatch(password);
  }

  void _attemptLogin() {
    String user = _userController.text;
    String password = _passwordController.text;

    if (user.isEmpty || password.isEmpty) {
      _showAlert('Por favor, preencha todos os campos.');
    } else if (user.length > 20 || password.length > 20) {
      _showAlert('Os campos não podem ultrapassar 20 caracteres.');
    } else if (user.endsWith(' ') || password.endsWith(' ')) {
      _showAlert('Os campos não podem terminar com espaço.');
    } else if (password.length < 2 || !_isPasswordValid(password)) {
      _showAlert(
          'A senha deve ter pelo menos 2 caracteres e não conter caracteres especiais.');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NextScreen()),
      );
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade800,
              Colors.teal.shade400,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Usuário',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Senha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: _attemptLogin,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      minimumSize: Size(150, 48),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: InkWell(
                child: Text(
                  'Política de Privacidade',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                onTap: _launchURL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
