import 'dart:convert'; // Para trabalhar com JSON
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;  // Importando o pacote HTTP
import 'package:tccmobile/users/autenticacao/sigup_screen.dart';

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

  Future<void> _login() async {
    if (formKey.currentState?.validate() ?? false) {
      String role = userType == 'Cliente' ? 'Client' : 'Pro';

      // Aqui você faz a requisição HTTP para o PHP
      final response = await http.get(Uri.parse('http://192.168.15.126/mobile/conexao.php')); // Substitua com o endereço correto do seu PHP

      if (response.statusCode == 200) {
        // Sucesso, processa o JSON
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Se o retorno for sucesso, você pode passar as informações para a próxima tela
          Get.off(DashboardPage(role: role, userType: userType));
        } else {
          // Se houver erro no retorno do servidor
          Get.snackbar('Erro', 'Erro ao conectar com o servidor.');
        }
      } else {
        // Caso a requisição falhe
        Get.snackbar('Erro', 'Falha na requisição ao servidor.');
      }
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
                                validator: (val) => (val == null || val.isEmpty) ? "Informe um email válido" : null,
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
                                validator: (val) => (val == null || val.isEmpty) ? "Informe uma senha válida" : null,
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
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
  final TextEditingController _orderTypeController = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();
  final TextEditingController _orderTimeController = TextEditingController();
  final TextEditingController _orderValueController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();

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
      'data': '06/10/2027',
      'valor': 120.0,
      'horario': '16:00',
    },
  ];

  // Lista para mensagens do chat
  final List<String> chatMessages = [];

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
    _orderTypeController.dispose();
    _orderDateController.dispose();
    _orderTimeController.dispose();
    _orderValueController.dispose();
    _chatController.dispose();
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

  void _addOrder() {
    final tipo = _orderTypeController.text;
    final data = _orderDateController.text;
    final horario = _orderTimeController.text;
    final valor = double.tryParse(_orderValueController.text);

    if (tipo.isNotEmpty && data.isNotEmpty && horario.isNotEmpty && valor != null && valor > 0) {
      setState(() {
        pendingClientOrders.add({
          'tipo': tipo,
          'data': data,
          'valor': valor,
          'horario': horario,
        });
        _orderTypeController.clear();
        _orderDateController.clear();
        _orderTimeController.clear();
        _orderValueController.clear();
      });
      Get.snackbar(
        "Pedido Adicionado",
        "Seu pedido de $tipo foi adicionado com sucesso!",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        "Erro",
        "Por favor, preencha todos os campos corretamente!",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void _sendMessage() {
    final message = _chatController.text;
    if (message.isNotEmpty) {
      setState(() {
        chatMessages.add('Você: $message');
        _chatController.clear();
      });
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
              // A remoção do método _showLoggedInDuration
              // substitui a chamada aqui por algo mais simples, se necessário
              // Por exemplo, exibir a duração diretamente em algum widget
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
          if (selectedPage == 'Adicionar Pedido')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _orderTypeController,
                    decoration: InputDecoration(
                      labelText: 'Tipo de Pedido',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _orderDateController,
                    decoration: InputDecoration(
                      labelText: 'Data (dd/mm/yyyy)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _orderTimeController,
                    decoration: InputDecoration(
                      labelText: 'Horário (hh:mm)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _orderValueController,
                    decoration: InputDecoration(
                      labelText: 'Valor do Pedido',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addOrder,
                    child: Text('Adicionar Pedido'),
                  ),
                ],
              ),
            ),
          if (selectedPage == 'Chat com o Profissional' && widget.userType == 'Cliente')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(chatMessages[index]),
                        );
                      },
                    ),
                  ),
                  TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      labelText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<PopupMenuItem<String>> _getMenuItems() {
    return [
      PopupMenuItem<String>(
        value: 'Dashboard Geral',
        child: _buildMenuItem(Icons.dashboard, 'Painel Geral'),
      ),
      PopupMenuItem<String>(
        value: 'Pedidos Pendentes',
        child: _buildMenuItem(Icons.pending, 'Pedidos Pendentes'),
      ),
      PopupMenuItem<String>(
        value: 'Pedidos Concluídos',
        child: _buildMenuItem(Icons.done, 'Pedidos Concluídos'),
      ),
      if (widget.userType == 'Cliente')
        PopupMenuItem<String>(
          value: 'Adicionar Pedido',
          child: _buildMenuItem(Icons.add, 'Adicionar Pedido'),
        ),
      if (widget.userType == 'Cliente')
        PopupMenuItem<String>(
          value: 'Chat com o Profissional',
          child: _buildMenuItem(Icons.chat, 'Chat com o Profissional'),
        ),
    ];
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  String getPageTitle(String page) {
    switch (page) {
      case 'Dashboard Geral':
        return 'Painel Geral';
      case 'Pedidos Pendentes':
        return 'Pedidos Pendentes';
      case 'Pedidos Concluídos':
        return 'Pedidos Concluídos';
      case 'Adicionar Pedido':
        return 'Adicionar Novo Pedido';
      case 'Chat com o Profissional':
        return 'Chat com o Profissional';
      default:
        return '';
    }
  }

  Widget getPageContent() {
    switch (selectedPage) {
      case 'Pedidos Pendentes':
        return ListView.builder(
          itemCount: pendingClientOrders.length,
          itemBuilder: (context, index) {
            final order = pendingClientOrders[index];
            return ListTile(
              title: Text('${order['tipo']} - ${order['valor']}'),
              subtitle: Text('Data: ${order['data']} - Horário: ${order['horario']}'),
            );
          },
        );
      case 'Pedidos Concluídos':
        return ListView.builder(
          itemCount: completedClientOrders.length,
          itemBuilder: (context, index) {
            final order = completedClientOrders[index];
            return ListTile(
              title: Text('${order['tipo']} - ${order['valor']}'),
              subtitle: Text('Data: ${order['data']} - Horário: ${order['horario']}'),
            );
          },
        );
      case 'Adicionar Pedido':
        return Container(); // O formulário de adição de pedidos já está no layout
      case 'Chat com o Profissional':
        return Container(); // O chat já está no layout
      default:
        return Center(
          child: Text('Selecione uma opção do menu'),
        );
    }
  }
}

// Tela de Registro (para futuras implementações)
class SigUpScreen extends StatelessWidget {
  const SigUpScreen({super.key});

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
