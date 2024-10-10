import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sigup_screen.dart';

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
      Get.off(DashboardPage(role: role, userType: userType));  // Passando também o tipo de usuário
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

// Dashboard
class DashboardPage extends StatefulWidget {
  final String role;
  final String userType;  // Tipo de usuário adicionado

  DashboardPage({required this.role, required this.userType});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedPage = 'Dashboard Geral';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel do ${widget.role}'),
        backgroundColor: Color(0xFF9370DB),
        actions: [
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
                selectedPage = value!;
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
          Expanded(
            child: getPageContent(),
          ),
        ],
      ),
    );
  }

  List<PopupMenuItem<String>> _getMenuItems() {
    if (widget.userType == 'Cliente') {
      return [
        PopupMenuItem<String>(
          value: 'Dashboard Geral',
          child: _buildMenuItem(Icons.dashboard, 'Dashboard Geral'),
        ),
        PopupMenuItem<String>(
          value: 'Pedidos Pendentes',
          child: _buildMenuItem(Icons.pending, 'Pedidos Pendentes'),
        ),
        PopupMenuItem<String>(
          value: 'Pedidos Concluídos',
          child: _buildMenuItem(Icons.check_circle, 'Pedidos Concluídos'),
        ),
        PopupMenuItem<String>(
          value: 'Chat com o Jogador',
          child: _buildMenuItem(Icons.chat, 'Chat com o Jogador'),
        ),
        PopupMenuItem<String>(
          value: 'Avaliações',
          child: _buildMenuItem(Icons.star, 'Avaliações'),  // A opção "Avaliações" para o Cliente
        ),
      ];
    } else {
      return [
        PopupMenuItem<String>(
          value: 'Dashboard Geral',
          child: _buildMenuItem(Icons.dashboard, 'Dashboard Geral'),
        ),
        PopupMenuItem<String>(
          value: 'Serviços Pendentes',
          child: _buildMenuItem(Icons.pending, 'Serviços Pendentes'),
        ),
        PopupMenuItem<String>(
          value: 'Serviços Concluídos',
          child: _buildMenuItem(Icons.check_circle, 'Serviços Concluídos'),
        ),
        PopupMenuItem<String>(
          value: 'Chat com o Cliente',
          child: _buildMenuItem(Icons.chat, 'Chat com o Cliente'),
        ),
        PopupMenuItem<String>(
          value: 'Saque',
          child: _buildMenuItem(Icons.attach_money, 'Saque'),  // A opção "Saque" para o Jogador
        ),
      ];
    }
  }

  static Widget _buildMenuItem(IconData icon, String text) {
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
      case 'Chat com o Jogador':
        return 'Chat com o Jogador';
      case 'Chat com o Cliente':
        return 'Chat com o Cliente';
      case 'Avaliações':
        return 'Aqui estão as suas avaliações.'; // Página de Avaliações
      case 'Saque':
        return 'Simulação de Saque';  // Página de Saque
      default:
        return 'Selecione uma opção.';
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
      case 'Saque':
        return const SaquePage(); // Chama a tela de saque
      default:
        return const Center(child: Text('Selecione uma opção.'));
    }
  }
}

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
      // Aqui você pode adicionar a lógica real para saque, se necessário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saque de R\$ $valor simulado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simule seu Saque',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Valor do Saque',
                labelStyle: const TextStyle(color: Colors.black),
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
    );
  }
}
