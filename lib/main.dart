import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para decodificar JSON
import 'package:tccmobile/users/autenticacao/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game Boosting Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Login(), // Página inicial
    );
  }
}

class ClienteListPage extends StatefulWidget {
  @override
  _ClienteListPageState createState() => _ClienteListPageState();
}

class _ClienteListPageState extends State<ClienteListPage> {
  List clientes = [];

  @override
  void initState() {
    super.initState();
    fetchClientes();
  }

  Future<void> fetchClientes() async {
    final url = 'http://192.168.15.126/mobile/conexao.php';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          clientes = data['data']; // Armazena os dados dos clientes
        });
      } else {
        print('Erro ao buscar clientes: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: clientes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          return ListTile(
            title: Text(cliente['nome']), // Exemplo: campo 'nome' do cliente
            subtitle: Text(cliente['email']), // Exemplo: campo 'email' do cliente
          );
        },
      ),
    );
  }
}
