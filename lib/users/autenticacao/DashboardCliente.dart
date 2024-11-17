import 'package:flutter/material.dart';

class DashboardCliente extends StatelessWidget {
  const DashboardCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Cliente'),
      ),
      body: Center(
        child: const Text('Bem-vindo ao Dashboard Cliente!'),
      ),
    );
  }
}
