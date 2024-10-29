import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Certifique-se de que o pacote GetX está instalado
import 'package:tccmobile/users/autenticacao/login.dart'; // Caminho correto para a classe Login
import 'package:http/http.dart' as http; // Importando o pacote http
import 'dart:convert'; // Importando para manipulação de JSON

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

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  List<dynamic> clientes = []; // Lista para armazenar os clientes

  @override
  void initState() {
    super.initState();
    fetchClientes(); // Chamando a função para buscar clientes ao iniciar
  }

  Future<void> fetchClientes() async {
    final response = await http.get(Uri.parse('http://http://192.168.15.126//mobile/conexao.php')); // Altere para o IP ou URL correta

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          clientes = data['data']; // Armazena a lista de clientes
        });
      } else {
        print('Erro: ${data['message']}');
      }
    } else {
      throw Exception('Falha ao carregar clientes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(clientes[index]['nome'] ?? 'Nome não disponível'), // Exibe o nome do cliente
            subtitle: Text(clientes[index]['email'] ?? 'Email não disponível'), // Exibe o email do cliente
          );
        },
      ),
    );
  }
}
