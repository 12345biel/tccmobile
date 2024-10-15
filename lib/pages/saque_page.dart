import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/pedido.dart';

class SaquePage extends StatefulWidget {
  const SaquePage({super.key});

  @override
  State<SaquePage> createState() => _SaquePageState();
}

class _SaquePageState extends State<SaquePage> {
  final TextEditingController saqueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _simularSaque() async {
    if (_formKey.currentState?.validate() ?? false) {
      double valor = double.parse(saqueController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saque de R\$ $valor simulado com sucesso!')),
      );

      // Exemplo de inserção de um pedido no banco de dados
      Pedido pedido = Pedido(
        id: DateTime.now().toString(),
        clienteId: 'Cliente1', // ajuste conforme necessário
        status: 'pendente',
        data: Pedido.dateTimeToString(DateTime.now()), descricao: '', // Converte DateTime para String
      );
      await DatabaseHelper.instance.insertPedido(pedido);
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
