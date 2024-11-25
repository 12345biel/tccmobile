import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DashboardCliente.dart';
import 'DashboardJogador.dart';

enum UserType { Cliente, Jogador }

class DashboardPage extends StatelessWidget {
  final String role;
  final UserType userType;

  const DashboardPage({super.key, required this.role, required this.userType});

  void _logout() {
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard - $role"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibindo o conteúdo do dashboard dependendo do tipo de usuário
          Expanded(
            child: userType == UserType.Cliente
                ? const DashboardCliente()
                : const DashboardJogador(),
          ),

          // Botão para navegar para a página de adicionar pedido (apenas para Clientes)
          if (userType == UserType.Cliente)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navega para a página de adicionar pedido
                  Get.to(() => AdicionarPedidoPage());  // Atualizado para navegação direta
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple, // Cor do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Borda arredondada
                  ),
                ),
                child: const Text(
                  'Adicionar Pedido',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
