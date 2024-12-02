import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccmobile/users/autenticacao/sigup_screen.dart';
import 'DashboardCliente.dart';
import 'DashboardJogador.dart';


//salvar dados
Future<void> saveUserData(Map<String, dynamic> userData, String usertype) async {
  final prefs = await SharedPreferences.getInstance();

  // Salve os dados necessários como Strings no SharedPreferences
  if (usertype == 'Jogador') {
    prefs.setInt('id', userData['id']);

    prefs.setString('name', userData['name']);

    prefs.setString('email', userData['email']);

    prefs.setString('rank', userData['rank']);

    prefs.setString('tel', userData['tel']);

    prefs.setString('cpf', userData['cpf']);

  } else {
    prefs.setInt('id', userData['id']);

    prefs.setString('name', userData['name']);

    prefs.setString('email', userData['email']);

    prefs.setString('tel', userData['tel']);

    prefs.setString('cpf', userData['cpf']);

  }

  print('Dados salvos localmente!');
}

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

  // Método para autenticação
  Future<bool> authenticateUser(String email, String senha, String usertype) async {
    final String apiUrl = usertype == "Jogador" ?
        'http://192.168.15.126/site/tcc-etec-angeers/api/getJogador.php'
        : 'http://192.168.15.126/site/tcc-etec-angeers/api/getUsuario.php';
    final Uri uri = Uri.parse('$apiUrl?email=$email&senha=$senha');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Verificar se a resposta indica sucesso
        if (data['status'] == 'success') {

          final datatype = usertype == 'Jogador' ? data['jogador'] : data['cliente'];

          // Salva os dados do jogador localmente

          await saveUserData(datatype, usertype);

          return true;
        }

      }

      return false;
    } catch (e) {
      print("Erro ao autenticar: $e");
      return false;
    }

  }

  void _login() async {
    if (formKey.currentState?.validate() ?? false) {
      // Mostrar carregamento durante a autenticação
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      // Chamar a função de autenticação
      final success = await authenticateUser(
        emailController.text,
        passwordController.text,
        userType
      );

      Get.back(); // Fechar o diálogo de carregamento

      if (success) {
        // Navegação para o dashboard com base no tipo de usuário
        if (userType == 'Cliente') {
          Get.off(() => const DashboardCliente());
        } else if (userType == 'Jogador') {
          Get.off(() => const DashboardJogador());
        }
      } else {
        // Mostrar mensagem de erro
        Get.snackbar(
          'Erro de Login',
          'Credenciais inválidas. Por favor, tente novamente.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
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
                    child: Image.asset("assets/logo3.png"),
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
                                validator: (val) =>
                                val!.isEmpty ? "Informe um email válido" : null,
                                decoration: InputDecoration(
                                  prefixIcon:
                                  const Icon(Icons.email, color: Colors.black),
                                  hintText: "email...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    const BorderSide(color: Colors.white60),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Obx(() => TextFormField(
                                controller: passwordController,
                                obscureText: isObsecure.value,
                                validator: (val) => val!.isEmpty
                                    ? "Informe uma senha válida"
                                    : null,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.vpn_key_sharp,
                                      color: Colors.black),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isObsecure.value = !isObsecure.value;
                                    },
                                    child: Icon(
                                      isObsecure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "password...",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                    const BorderSide(color: Colors.white60),
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
                                  labelStyle:
                                  TextStyle(color: Color(0xFFA88A6F)),
                                ),
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'Cliente',
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, color: Colors.black),
                                        SizedBox(width: 8),
                                        Text('Cliente',
                                            style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Jogador',
                                    child: Row(
                                      children: [
                                        Icon(Icons.gamepad, color: Colors.black),
                                        SizedBox(width: 8),
                                        Text('Jogador',
                                            style: TextStyle(color: Colors.black)),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 28),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?",
                                      style:
                                      TextStyle(color: Colors.white60)),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => const SignUpScreen());
                                    },
                                    child: const Text(
                                      "Register Here",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
