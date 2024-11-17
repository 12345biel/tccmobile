import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tccmobile/users/autenticacao/login.dart'; // Caminho para a tela de login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage(
        'Game Boosting',
        'A plataforma que vai melhorar sua experiência de jogo.',
        Icons.gamepad_outlined,
      ),
      _buildPage(
        'Acesso Rápido',
        'Entre facilmente em seu painel para gerenciar pedidos e acompanhar o progresso.',
        Icons.access_alarm_outlined,
      ),
      _buildPage(
        'Segurança',
        'Sistemas de segurança para proteger sua conta e seus dados.',
        Icons.security_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: pages,
      ),
    );
  }

  Widget _buildPage(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 120,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // Navega para a tela de login
              Get.to(() => const Login());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: Text(
              'Acessar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Cor do texto alterada para branco
              ),
            ),
          ),
        ],
      ),
    );
  }
}
