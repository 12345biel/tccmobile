import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

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
        appBarTheme: AppBarTheme(
          color: Colors.indigo,
          titleTextStyle: const TextStyle(
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
      Get.off(DashboardPage(role: role, userType: userType));
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
                                validator: (val) => val == "" ? "Informe um email válido" : null,
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
                                validator: (val) => val == "" ? "Informe uma senha válida" : null,
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

//Dashboard
class DashboardPage extends StatefulWidget {
  final String role;
  final String userType;

  DashboardPage({required this.role, required this.userType});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedPage = 'Dashboard Geral';
  late Timer _timer;
  late Timer _reminderTimer;
  Duration _loggedInDuration = Duration();
  String _reminderMessage = '';
  final TextEditingController _withdrawalController = TextEditingController();

  // Exemplos de serviços e pedidos do cliente
  final List<Map<String, dynamic>> pendingClientOrders = [
    {
      'tipo': 'Coating',
      'data': '01/10/2023',
      'valor': 100.0,
      'horario': '14:00',
    },
    {
      'tipo': 'Boosting',
      'data': '05/10/2023',
      'valor': 150.0,
      'horario': '15:30',
    },
  ];

  final List<Map<String, dynamic>> completedClientOrders = [
    {
      'tipo': 'Coating',
      'data': '02/10/2023',
      'valor': 80.0,
      'horario': '10:00',
    },
    {
      'tipo': 'Boosting',
      'data': '06/10/2023',
      'valor': 120.0,
      'horario': '16:00',
    },
  ];

  // Exemplos de serviços do jogador
  final List<Map<String, dynamic>> pendingPlayerServices = [
    {
      'tipo': 'Match Coaching',
      'data': '03/10/2023',
      'valor': 200.0,
      'horario': '12:00',
    },
    {
      'tipo': 'Performance Review',
      'data': '07/10/2023',
      'valor': 180.0,
      'horario': '18:00',
    },
  ];

  final List<Map<String, dynamic>> completedPlayerServices = [
    {
      'tipo': 'Match Analysis',
      'data': '04/10/2023',
      'valor': 150.0,
      'horario': '15:00',
    },
    {
      'tipo': 'Training Session',
      'data': '08/10/2023',
      'valor': 220.0,
      'horario': '10:30',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
    _startReminderTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _reminderTimer.cancel();
    _withdrawalController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _loggedInDuration += Duration(seconds: 1);
      });
    });
  }

  void _startReminderTimer() {
    _reminderTimer = Timer.periodic(Duration(seconds: 90), (timer) {
      _showReminder();
    });
  }

  String getDurationString() {
    int hours = _loggedInDuration.inHours;
    int minutes = (_loggedInDuration.inMinutes % 60);
    int seconds = (_loggedInDuration.inSeconds % 60);
    return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void _showReminder() {
    setState(() {
      _reminderMessage = "Lembrete: Você está logado há ${getDurationString()}!";
    });

    Timer(Duration(seconds: 15), () {
      setState(() {
        _reminderMessage = '';
      });
    });
  }

  void _simulateWithdrawal() {
    final double? amount = double.tryParse(_withdrawalController.text);
    if (amount != null && amount > 0) {
      _withdrawalController.clear();
      Get.snackbar(
        "Saque Realizado",
        "Você sacou R\$${amount.toStringAsFixed(2)} com sucesso!",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        "Erro",
        "Por favor, insira um valor válido!",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel do ${widget.role}'),
        backgroundColor: Color(0xFF9370DB),
        actions: [
          IconButton(
            icon: const Icon(Icons.access_time),
            onPressed: () {
              _showLoggedInDuration();
            },
            tooltip: 'Horário',
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              getPageTitle(selectedPage),
              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          if (_reminderMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _reminderMessage,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          Expanded(
            child: getPageContent(),
          ),
          if (selectedPage == 'Saque')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _withdrawalController,
                    decoration: InputDecoration(
                      labelText: 'Valor do Saque',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _simulateWithdrawal,
                    child: Text('Realizar Saque'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showLoggedInDuration() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tempo Logado"),
          content: Text("Você está logado há: ${getDurationString()}"),
          actions: [
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<PopupMenuItem<String>> _getMenuItems() {
    return [
      PopupMenuItem<String>(
        value: 'Dashboard Geral',
        child: _buildMenuItem(Icons.dashboard, 'Dashboard Geral'),
      ),
      PopupMenuItem<String>(
        value: widget.userType == 'Cliente' ? 'Pedidos Pendentes' : 'Serviços Pendentes',
        child: _buildMenuItem(Icons.pending, widget.userType == 'Cliente' ? 'Pedidos Pendentes' : 'Serviços Pendentes'),
      ),
      PopupMenuItem<String>(
        value: widget.userType == 'Cliente' ? 'Pedidos Concluídos' : 'Serviços Concluídos',
        child: _buildMenuItem(Icons.check_circle, widget.userType == 'Cliente' ? 'Pedidos Concluídos' : 'Serviços Concluídos'),
      ),
      if (widget.role == 'Pro')
        PopupMenuItem<String>(
          value: 'Chat com o Cliente',
          child: _buildMenuItem(Icons.chat, 'Chat com o Cliente'),
        ),
      if (widget.role == 'Client')
        PopupMenuItem<String>(
          value: 'Chat com o Profissional',
          child: _buildMenuItem(Icons.person, 'Chat com o Profissional'),
        ),
      if (widget.role == 'Pro')
        PopupMenuItem<String>(
          value: 'Saque',
          child: _buildMenuItem(Icons.attach_money, 'Saque'),
        ),
    ];
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  String getPageTitle(String page) {
    switch (page) {
      case 'Dashboard Geral':
        return 'Bem-vindo ao Dashboard Geral!';
      case 'Pedidos Pendentes':
        return 'Aqui estão os pedidos pendentes.';
      case 'Pedidos Concluídos':
        return 'Aqui estão os pedidos concluídos.';
      case 'Serviços Pendentes':
        return 'Aqui estão os serviços pendentes.';
      case 'Serviços Concluídos':
        return 'Aqui estão os serviços concluídos.';
      case 'Saque':
        return 'Simulação de Saque';
      case 'Chat com o Cliente':
        return 'Chat com o Cliente';
      case 'Chat com o Profissional':
        return 'Chat com o Profissional';
      default:
        return 'Dashboard Geral';
    }
  }

  Widget getPageContent() {
    switch (selectedPage) {
      case 'Dashboard Geral':
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.dashboard, size: 80, color: Colors.indigo),
              SizedBox(height: 20),
              Text(
                'Esta é uma visão geral do seu painel.',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        );
      case 'Pedidos Pendentes':
        return ListView.builder(
          itemCount: pendingClientOrders.length,
          itemBuilder: (context, index) {
            final order = pendingClientOrders[index];
            return ListTile(
              title: Text(
                '${order['tipo']} - R\$${order['valor'].toStringAsFixed(2)}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Data: ${order['data']} - Horário: ${order['horario']}',
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        );
      case 'Pedidos Concluídos':
        return ListView.builder(
          itemCount: completedClientOrders.length,
          itemBuilder: (context, index) {
            final order = completedClientOrders[index];
            return ListTile(
              title: Text(
                '${order['tipo']} - R\$${order['valor'].toStringAsFixed(2)}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Data: ${order['data']} - Horário: ${order['horario']}',
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        );
      case 'Serviços Pendentes':
        return ListView.builder(
          itemCount: pendingPlayerServices.length,
          itemBuilder: (context, index) {
            final service = pendingPlayerServices[index];
            return ListTile(
              title: Text(
                '${service['tipo']} - R\$${service['valor'].toStringAsFixed(2)}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Data: ${service['data']} - Horário: ${service['horario']}',
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        );
      case 'Serviços Concluídos':
        return ListView.builder(
          itemCount: completedPlayerServices.length,
          itemBuilder: (context, index) {
            final service = completedPlayerServices[index];
            return ListTile(
              title: Text(
                '${service['tipo']} - R\$${service['valor'].toStringAsFixed(2)}',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Data: ${service['data']} - Horário: ${service['horario']}',
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        );
      case 'Chat com o Cliente':
        return const Center(child: Text('Aqui é o chat com o cliente.', style: TextStyle(color: Colors.black)));
      case 'Chat com o Profissional':
        return const Center(child: Text('Aqui é o chat com o profissional.', style: TextStyle(color: Colors.black)));
      case 'Saque':
        return const Center(child: Text('Aqui você pode realizar um saque.', style: TextStyle(color: Colors.black)));
      default:
        return const Center(child: Text('Selecione uma opção.', style: TextStyle(color: Colors.black)));
    }
  }
}

// Tela de Registro (para futuras implementações)
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: const Center(
        child: Text('Formulário de Registro'),
      ),
    );
  }
}



