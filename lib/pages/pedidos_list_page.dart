import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/pedido.dart';

class PedidosListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: FutureBuilder<List<Pedido>>(
        future: DatabaseHelper.instance.getPedidos(), // Use a instância do singleton
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum pedido encontrado.'));
          } else {
            final pedidos = snapshot.data!;
            return ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                return ListTile(
                  title: Text('Pedido ${pedido.id} - ${pedido.status}'),
                  subtitle: Text('Cliente: ${pedido.clienteId} - Data: ${pedido.data}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
