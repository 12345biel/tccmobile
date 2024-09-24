import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Certifique-se de que o pacote GetX está instalado
import 'package:tccmobile/users/autenticacao/login.dart'; // Caminho correto para a classe Login

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Usa GetMaterialApp para configurar GetX
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(), // Página inicial
    );
  }
}
