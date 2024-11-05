import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Certifique-se de que o pacote GetX está instalado
import 'package:tccmobile/users/autenticacao/login.dart'; // Caminho correto para a classe Login

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Inicializa os bindings do Flutter
  runApp(const MyApp()); // Executa o aplicativo
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Usa GetMaterialApp para configurar GetX
      title: 'Game Boosting Dashboard',
      debugShowCheckedModeBanner: false, // Remove a faixa de depuração
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define a paleta de cores primária
        visualDensity: VisualDensity.adaptivePlatformDensity, // Adapta a densidade visual para diferentes dispositivos
        scaffoldBackgroundColor: Colors.white, // Define a cor de fundo do Scaffold
      ),
      home: const Login(), // Página inicial
    );
  }
}
