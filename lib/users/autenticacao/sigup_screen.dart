import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final rankController = TextEditingController();

  String userType = 'Cliente'; // Valor padrão

  // Função para cadastro
  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      final url = 'http://192.168.15.126/mobile/conexao.php';
      final response = await http.post(Uri.parse(url), body: {
        'nome': nomeController.text,
        'telefone': telefoneController.text,
        'cpf': cpfController.text,
        'email': emailController.text,
        'senha': passwordController.text,
        'rank': rankController.text,
        'tipo_usuario': userType,
      });

      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        Get.back();
      } else {
        print('Erro ao cadastrar: ${data['message']}');
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
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                        child: Column(
                          children: [
                            // Seção de escolha de tipo de usuário (Cliente ou Jogador)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      userType = 'Cliente';
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.person, color: Colors.black),
                                      Text(
                                        "Cliente",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      if (userType == 'Cliente')
                                        Container(
                                          width: 60,
                                          height: 2,
                                          color: Colors.white,
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 40), // Espaço entre os ícones
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      userType = 'Jogador';
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.gamepad, color: Colors.black),
                                      Text(
                                        "Jogador",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      if (userType == 'Jogador')
                                        Container(
                                          width: 60,
                                          height: 2,
                                          color: Colors.white,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18), // Espaçamento entre os ícones e o formulário

                            // Formulário com campos específicos para o cliente ou jogador
                            userType == 'Cliente' ? ClienteForm(
                              formKey: formKey,
                              nomeController: nomeController,
                              telefoneController: telefoneController,
                              cpfController: cpfController,
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmPasswordController: confirmPasswordController,
                              register: register,
                            ) : JogadorForm(
                              formKey: formKey,
                              nomeController: nomeController,
                              telefoneController: telefoneController,
                              cpfController: cpfController,
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmPasswordController: confirmPasswordController,
                              rankController: rankController,
                              register: register,
                            ),
                          ],
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

class ClienteForm extends StatelessWidget {
  const ClienteForm({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.telefoneController,
    required this.cpfController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.register,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController telefoneController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback register;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Campo Nome
          TextFormField(
            controller: nomeController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu nome" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.black),
              hintText: "nome...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Telefone
          TextFormField(
            controller: telefoneController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu telefone" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone, color: Colors.black),
              hintText: "telefone...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo CPF
          TextFormField(
            controller: cpfController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu CPF" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.assignment_ind, color: Colors.black),
              hintText: "cpf...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Email
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

          // Campo Senha
          TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: (val) => (val == null || val.isEmpty) ? "Informe uma senha válida" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.vpn_key_sharp, color: Colors.black),
              hintText: "senha...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Confirmar Senha
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Confirme sua senha";
              }
              if (val != passwordController.text) {
                return "Senhas não coincidem";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.vpn_key, color: Colors.black),
              hintText: "confirmar senha...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

        // Botão de Cadastro
        ElevatedButton(
          onPressed: register,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA88A6F), // Cor de fundo
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Cadastrar",
            style: TextStyle(
              color: Colors.white, // Cor do texto em branco
            ),
          ),
         )
        ],
      ),
    );
  }
}

class JogadorForm extends StatelessWidget {
  const JogadorForm({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.telefoneController,
    required this.cpfController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.rankController,
    required this.register,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController telefoneController;
  final TextEditingController cpfController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController rankController;
  final VoidCallback register;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Campo Nome
          TextFormField(
            controller: nomeController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu nome" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.black),
              hintText: "nome...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Telefone
          TextFormField(
            controller: telefoneController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu telefone" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone, color: Colors.black),
              hintText: "telefone...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo CPF
          TextFormField(
            controller: cpfController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu CPF" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.assignment_ind, color: Colors.black),
              hintText: "cpf...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Email
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

          // Campo Senha
          TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: (val) => (val == null || val.isEmpty) ? "Informe uma senha válida" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.vpn_key_sharp, color: Colors.black),
              hintText: "senha...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Confirmar Senha
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Confirme sua senha";
              }
              if (val != passwordController.text) {
                return "Senhas não coincidem";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.vpn_key, color: Colors.black),
              hintText: "confirmar senha...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

          // Campo Rank (apenas para Jogador)
          TextFormField(
            controller: rankController,
            validator: (val) => (val == null || val.isEmpty) ? "Informe seu rank" : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.star, color: Colors.black),
              hintText: "rank...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 18),

        // Botão de Cadastro
        ElevatedButton(
          onPressed: register,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA88A6F), // Cor de fundo
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Cadastrar",
            style: TextStyle(
              color: Colors.white, // Cor do texto em branco
            ),
          ),
         )
        ],
      ),
    );
  }
}
