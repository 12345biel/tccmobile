import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tccmobile/users/autenticacao/sigup_screen.dart'; // Certifique-se de que o caminho está correto
import 'DashboardCliente.dart';
import 'DashboardJogador.dart';

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
      // Navegação para o dashboard com base no tipo de usuário
      if (userType == 'Cliente') {
        Get.off(() => const DashboardCliente());
      } else if (userType == 'Jogador') {
        Get.off(() => const DashboardJogador());
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
                                validator: (val) => val!.isEmpty ? "Informe um email válido" : null,
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
                                validator: (val) => val!.isEmpty ? "Informe uma senha válida" : null,
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
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'Cliente',
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, color: Colors.black),
                                        SizedBox(width: 8),
                                        Text('Cliente', style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Jogador',
                                    child: Row(
                                      children: [
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
                                      Get.to(() => const SignUpScreen()); // Navegação para o registro
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
