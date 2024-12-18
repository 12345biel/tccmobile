import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tccmobile/users/autenticacao/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final eloController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isObsecure = true.obs;
  String accountType = 'Jogador'; // Tipo de conta selecionado

  void _setAccountType(String type) {
    setState(() {
      accountType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua Conta'),
        backgroundColor: Color(0xFF9370DB),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF9370DB),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Linha com ícones
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.gamepad, color: accountType == 'Jogador' ? Colors.white : Colors.grey), // Ícone de controle de videogame
                                onPressed: () => _setAccountType('Jogador'),
                              ),
                              Text(
                                "Crie sua Conta",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.person, color: accountType == 'Cliente' ? Colors.white : Colors.grey), // Ícone de pessoa
                                onPressed: () => _setAccountType('Cliente'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Campos de entrada baseados no tipo de conta
                          if (accountType == 'Jogador') ...[
                            _buildJogadorFields(), // Campos específicos para Jogador
                          ] else if (accountType == 'Cliente') ...[
                            _buildClienteFields(), // Campos específicos para Cliente
                          ],
                          const SizedBox(height: 20),

                          // Botão de Registro
                          Material(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  // Adicione sua lógica de registro aqui
                                  Get.snackbar("Sucesso", "Conta criada com sucesso!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white);

                                  // Navegar para a tela de login após um pequeno delay
                                  Future.delayed(const Duration(seconds: 2), () {
                                    Get.offAll(() => Login());
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                                child: Text(
                                  "Registrar",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Link para login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Já tem uma conta? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back(); // Navega para a tela anterior de login
                                },
                                child: const Text(
                                  "Faça login",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
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
            );
          },
        ),
      ),
    );
  }

  // Métodos para os campos de Jogador
  Widget _buildJogadorFields() {
    return Column(
      children: [
        _buildTextField(nameController, "nome...", Icons.person, "Informe um nome válido"),
        _buildTextField(emailController, "email...", Icons.email, "Informe um email válido"),
        _buildTextField(phoneController, "telefone...", Icons.phone, "Informe um telefone válido"),
        _buildTextField(cpfController, "cpf...", Icons.assignment_ind, "Informe um CPF válido"), // Campo CPF
        _buildTextField(eloController, "elo...", Icons.star, "Informe seu elo"),
        _buildPasswordField(),
        _buildConfirmPasswordField(),
      ],
    );
  }

  // Métodos para os campos de Cliente
  Widget _buildClienteFields() {
    return Column(
      children: [
        _buildTextField(nameController, "nome...", Icons.person, "Informe um nome válido"),
        _buildTextField(emailController, "email...", Icons.email, "Informe um email válido"),
        _buildTextField(phoneController, "telefone...", Icons.phone, "Informe um telefone válido"),
        _buildTextField(cpfController, "cpf...", Icons.assignment_ind, "Informe um CPF válido"), // Campo CPF
        _buildPasswordField(),
        _buildConfirmPasswordField(),
      ],
    );
  }

  // Método para construir campos de texto
  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, String validationMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: (val) => val == "" ? validationMessage : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  // Método para construir o campo de senha
  Widget _buildPasswordField() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
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
          hintText: "senha...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    ));
  }

  // Método para construir o campo de confirmação de senha
  Widget _buildConfirmPasswordField() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: confirmPasswordController,
        obscureText: isObsecure.value,
        validator: (val) => val == "" ? "Informe a confirmação da senha" : null,
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
          hintText: "confirme a senha...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white60),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    ));
  }
}
