import 'package:flutter/material.dart';
import 'package:tccmobile/database_helper.dart';
import 'package:tccmobile/models/pedido.dart';

class AdicionarPedidoPage extends StatefulWidget {
  final String clienteId;

  const AdicionarPedidoPage({Key? key, required this.clienteId}) : super(key: key);

  @override
  AdicionarPedidoPageState createState() => AdicionarPedidoPageState();
}

class AdicionarPedidoPageState extends State<AdicionarPedidoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descricaoController = TextEditingController();

  void _adicionarPedido() {
    if (_formKey.currentState?.validate() ?? false) {
      Pedido pedido = Pedido(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        clienteId: widget.clienteId,
        status: 'pendente',
        data: Pedido.dateTimeToString(DateTime.now()),
        descricao: descricaoController.text,
      );

      DatabaseHelper.instance.insertPedido(pedido).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pedido adicionado com sucesso!')),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar pedido: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Pedido'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: widget.clienteId,
                decoration: InputDecoration(
                  labelText: 'ID do Cliente',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                enabled: false,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição do Pedido',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição válida.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _adicionarPedido,
                child: Text('Adicionar Pedido'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
