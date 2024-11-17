import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DashboardCliente.dart';
import 'DashboardJogador.dart';

class DashboardPage extends StatelessWidget {
  final String role;
  final String userType;

  const DashboardPage({super.key, required this.role, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard - $role"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Lógica para logout
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      body: userType == 'Cliente' ? const DashboardCliente() : const DashboardJogador(),
    );
  }
}
