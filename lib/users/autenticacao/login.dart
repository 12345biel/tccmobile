import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tccmobile/models/servico.dart';
import 'package:tccmobile/users/autenticacao/sigup_screen.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tccmobile/database_helper.dart';
import 'package:tccmobile/models/pedido.dart';
import 'package:tccmobile/pages/adicionar_pedido.dart';
import 'package:tccmobile/users/autenticacao/chat_screen.dart';



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
        appBarTheme: const AppBarTheme(
          color: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Color(0xFFA88A6F),
            fontFamily: 'PressStart2P',
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFFA88A6F),
            fontFamily: 'PressStart2P',
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFA88A6F),
            fontFamily: 'PressStart2P',
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: const Login(),
    );
  }
}

// Login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isObsecure = true.obs;

  String userType = 'Cliente';

  void _login() {
    if (formKey.currentState?.validate() ?? false) {
      String role = userType == 'Cliente' ? 'Client' : 'Pro';

      // Redireciona para a página do painel com a função Get.off
      Get.off(() => DashboardPage(role: role, userType: userType));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF9370DB),
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                validator: (val) => val == ""
                                    ? "Informe um email válido"
                                    : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                                  hintText: "email...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(color: Colors.white60),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Obx(() => TextFormField(
                                controller: passwordController,
                                obscureText: isObsecure.value,
                                validator: (val) => val == ""
                                    ? "Informe uma senha válida"
                                    : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.vpn_key_sharp, color: Colors.black),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isObsecure.value = !isObsecure.value;
                                    },
                                    child: Icon(
                                      isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "password...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(color: Colors.white60),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              )),
                              const SizedBox(height: 18),
                              DropdownButtonFormField<String>(
                                value: userType,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Color(0xFFA88A6F)),
                                ),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Cliente',
                                    child: Row(
                                      children: const [
                                        Icon(Icons.person, color: Colors.black),
                                        SizedBox(width: 8),
                                        Text('Cliente', style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Jogador',
                                    child: Row(
                                      children: const [
                                        Icon(Icons.gamepad, color: Colors.black),
                                        SizedBox(width: 8),
                                        Text('Jogador', style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    userType = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, selecione o tipo de usuário';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              Material(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: _login,
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?", style: TextStyle(color: Colors.white60)),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => const SignUpScreen());
                                    },
                                    child: const Text(
                                      "Register Here",
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Dashboard
class DashboardPage extends StatefulWidget {
  final String role;
  final String userType;

  const DashboardPage({super.key, required this.role, required this.userType});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedPage = 'Dashboard Geral';
  Duration loginDuration = Duration(); // Variável para armazenar o tempo de login
  Timer? timer; // Timer para atualizar o tempo
  bool showLoginDuration = false; // Variável para controlar a exibição do tempo

  @override
  void initState() {
    super.initState();
    // Iniciar o timer que atualiza a duração de login a cada segundo
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        loginDuration += Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancelar o timer ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel do ${widget.role}'),
        backgroundColor: Color(0xFF9370DB),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
            onPressed: () {
              setState(() {
                showLoginDuration = !showLoginDuration; // Alterna a exibição do tempo
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Get.off(const Login());
            },
            tooltip: 'Deslogar',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              setState(() {
                selectedPage = value;
              });
            },
            itemBuilder: (context) => _getMenuItems(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                showLoginDuration ? 'Tempo de login: ${loginDuration.inSeconds} segundos' : '',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(child: _getPageContent(selectedPage)),
        ],
      ),
    );
  }

  List<PopupMenuEntry<String>> _getMenuItems() {
    return [
      const PopupMenuItem(value: 'Dashboard Geral', child: Text('Dashboard Geral')),
      const PopupMenuItem(value: 'Adicionar Pedido', child: Text('Adicionar Pedido')),
      const PopupMenuItem(value: 'Chat', child: Text('Chat')),
    ];
  }

  Widget _getPageContent(String selectedPage) {
    switch (selectedPage) {
      case 'Adicionar Pedido':
        return AdicionarPedido();
      case 'Chat':
        return ChatScreen();
      case 'Dashboard Geral':
      default:
        return Center(child: Text('Bem-vindo ao Dashboard!'));
    }
  }
}


// Tela de Pedidos
class PedidosPage extends StatelessWidget {
  final String status;

  const PedidosPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Aqui você pode buscar os pedidos com base no status
    List<Pedido> pedidos = [
      Pedido(
        id: '1',
        clienteId: 'Cliente1',
        status: status,
        data: Pedido.dateTimeToString(DateTime.now()), descricao: '', // Converte DateTime para String
      ),
      Pedido(
        id: '2',
        clienteId: 'Cliente2',
        status: status,
        data: Pedido.dateTimeToString(DateTime.now().subtract(Duration(days: 1))), descricao: '', // Converte DateTime para String
      ),
    ];


    return ListView.builder(
      itemCount: pedidos.length,
      itemBuilder: (context, index) {
        final pedido = pedidos[index];
        return ListTile(
          title: Text('Pedido ${pedido.id} - ${pedido.status}'),
          subtitle: Text('Data: ${pedido.data}'),
        );
      },
    );
  }
}

// Tela de Serviços
class ServicosPage extends StatelessWidget {
  final String status;

  const ServicosPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Aqui você pode buscar os serviços com base no status
    List<Servico> servicos = [
      Servico(
        id: '1',
        jogadorId: 'Jogador1',
        tipo: 'Game Boosting',
        status: status,
        data: Servico.dateTimeToString(DateTime.now()), // Converte DateTime para String
      ),
      Servico(
        id: '2',
        jogadorId: 'Jogador2',
        tipo: 'Coaching',
        status: status,
        data: Servico.dateTimeToString(DateTime.now().subtract(Duration(days: 1))), // Converte DateTime para String
      ),
    ];


    return ListView.builder(
      itemCount: servicos.length,
      itemBuilder: (context, index) {
        final servico = servicos[index];
        return ListTile(
          title: Text('Serviço ${servico.id} - ${servico.tipo} - ${servico.status}'),
          subtitle: Text('Data: ${servico.data}'),
        );
      },
    );
  }
}

// Tela de Saque
class SaquePage extends StatefulWidget {
  const SaquePage({super.key});

  @override
  State<SaquePage> createState() => _SaquePageState();
}

class _SaquePageState extends State<SaquePage> {
  final TextEditingController saqueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _simularSaque() {
    if (_formKey.currentState?.validate() ?? false) {
      double valor = double.parse(saqueController.text);
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Saque de R\$ $valor simulado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simular Saque')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Simule seu Saque',
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: saqueController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Digite um valor válido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Valor do Saque',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simularSaque,
                child: const Text('Simular Saque'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

