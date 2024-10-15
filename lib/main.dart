import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tccmobile/database_helper.dart';
import 'package:tccmobile/models/pedido.dart' as pedido_model; // Alias para Pedido
import 'package:tccmobile/pages/adicionar_pedido.dart';
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    String formattedDate = DateTime.now().toIso8601String();

    try {
      await dbHelper.insertPedido(pedido_model.Pedido(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        clienteId: 'Client1',
        status: 'pendent',
        data: formattedDate, descricao: '',
      ));
    } catch (e) {
      print('Erro ao inserir pedido: $e');
    }
  }

  Future<void> _closeDatabase() async {
    await dbHelper.closeDatabase(); // Fecha o banco de dados
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Banco de dados desativado!')),
    );

    // Redireciona para a página de login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
          (route) => false, // Remove todas as rotas anteriores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdicionarPedidoPage(clienteId: '',)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _closeDatabase, // Desativa o banco de dados
          ),
        ],
      ),
      body: Center(
        child: const Text('Banco de dados inicializado!'),
      ),
    );
  }
}
