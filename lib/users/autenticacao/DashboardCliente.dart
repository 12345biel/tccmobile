import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Remove todos os dados salvos
}


// Página de pedidos pendentes
class PendingOrdersPage extends StatelessWidget {
  const PendingOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pendingOrders = [
      {
        'title': 'EloBoosting #001',
        'description': 'Compra de pacote EloBoosting em progresso',
        'status': 'Aguardando confirmação',
      },
      {
        'title': 'DuoBoosting #002',
        'description': 'Serviço DuoBoosting agendado',
        'status': 'Em análise',
      },
      {
        'title': 'Coach #003',
        'description': 'Sessão de Coach agendada',
        'status': 'Preparando para envio',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedidos Pendentes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: pendingOrders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
            SizedBox(height: 8),
            Text('Nenhum pedido pendente.', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        itemCount: pendingOrders.length,
        itemBuilder: (context, index) {
          final order = pendingOrders[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(15.0),
              leading: Icon(
                Icons.pending_actions,
                color: Colors.orange,
                size: 40,
              ),
              title: Text(
                order['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                order['description']!,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  color: _getStatusColor(order['status']!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order['status']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                // Navega para a página de chat com o profissional
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Método para retornar a cor do status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Aguardando confirmação':
        return Colors.orange;
      case 'Em análise':
        return Colors.blue;
      case 'Preparando para envio':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}



// Página de pedidos concluidos
class CompletedOrdersPage extends StatelessWidget {
  const CompletedOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> completedOrders = [
      {
        'title': 'EloBoosting #001',
        'description': 'Pacote EloBoosting concluído com sucesso',
        'status': 'Concluído',
      },
      {
        'title': 'DuoBoosting #002',
        'description': 'Serviço DuoBoosting finalizado',
        'status': 'Concluído',
      },
      {
        'title': 'Coach #003',
        'description': 'Sessão de Coach completada',
        'status': 'Concluído',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedidos Concluídos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: completedOrders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle_outline, size: 50, color: Colors.green),
            SizedBox(height: 8),
            Text('Nenhum pedido concluído.', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        itemCount: completedOrders.length,
        itemBuilder: (context, index) {
          final order = completedOrders[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(15.0),
              leading: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 40,
              ),
              title: Text(
                order['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                order['description']!,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Concluído',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Página de chat com o Profissional
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat com o Profissional'),
        backgroundColor: Colors.purple.shade700, // Cor de fundo da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              leading: CircleAvatar(
                radius: 20,
                child: Icon(
                  Icons.person,
                  color: Colors.black26,
                  size: 30, // Ajuste o tamanho do ícone conforme necessário
                ),
              ),
              title: Text(
                'Usuário ${index + 1}', // Nome do usuário (1 a 4)
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Clique para iniciar o chat',
                style: const TextStyle(color: Colors.black54),
              ),
              onTap: () {
                // Ao clicar no usuário, abre a tela de chat privado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatWithProfessionalPage(playerIndex: index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ChatWithProfessionalPage extends StatefulWidget {
  final int playerIndex;

  const ChatWithProfessionalPage({required this.playerIndex, super.key});

  @override
  _ChatWithProfessionalPageState createState() => _ChatWithProfessionalPageState();
}

class _ChatWithProfessionalPageState extends State<ChatWithProfessionalPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    // Inicializa as mensagens com base no índice do usuário
    _messages = [
      'Usuário ${widget.playerIndex + 1}: Olá, como posso ajudar você?',
      'Profissional: Oi, estou com uma dúvida!',
    ];
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add('Usuário ${widget.playerIndex + 1}: ${_controller.text}');
        _messages.add('Profissional: Resposta automática!');
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat com Profissional ${widget.playerIndex + 1}'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Lista de mensagens
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isProfessionalMessage = message.startsWith('Profissional');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Align(
                    alignment: isProfessionalMessage ? Alignment.topLeft : Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isProfessionalMessage ? Colors.grey.shade200 : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: isProfessionalMessage ? Colors.black : Colors.blue.shade900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Área para digitar mensagens
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Campo de texto
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // Botão de enviar
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Página de adicionar pedido
class AdicionarPedidoPage extends StatefulWidget {
  const AdicionarPedidoPage({super.key});

  @override
  _AdicionarPedidoPageState createState() => _AdicionarPedidoPageState();
}

class _AdicionarPedidoPageState extends State<AdicionarPedidoPage> {
  final TextEditingController _pedidoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  String _selectedService = '';
  String _selectedTema = '';

  // Lista de serviços com seus dados
  final List<Map<String, String>> _services = [
    {'name': 'EloBoosting', 'description': 'Melhore seu ranking com um boost de elo personalizado.', 'price': 'A partir de R\$99,99'},
    {'name': 'DuoBoosting', 'description': 'Aumente seu elo jogando com um parceiro experiente.', 'price': 'A partir de R\$149,99'},
    {'name': 'Coach', 'description': 'Receba dicas e treinos personalizados de um coach profissional.', 'price': 'A partir de R\$199,99'},
  ];

  // Método para atualizar os campos quando um serviço é selecionado
  void _atualizarCampos(String tema) {
    final selectedService = _services.firstWhere((service) => service['name'] == tema);
    setState(() {
      _descricaoController.text = selectedService['description']!;
      _precoController.text = selectedService['price']!;
    });
  }

  // Método para adicionar o pedido
  void _adicionarPedido() {
    if (_pedidoController.text.isNotEmpty && _quantidadeController.text.isNotEmpty && _descricaoController.text.isNotEmpty && _precoController.text.isNotEmpty && _selectedService.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido "${_pedidoController.text}" para o serviço "$_selectedService" adicionado!')),
      );

      _pedidoController.clear();
      _quantidadeController.clear();
      _descricaoController.clear();
      _precoController.clear();
      setState(() {
        _selectedService = '';
        _selectedTema = '';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Pedido'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView( // Envolvendo o conteúdo com SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione o Serviço',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Exibe os serviços disponíveis como opções de seleção
            for (var service in _services)
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(service['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service['description']!),
                      Text(service['price']!, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    setState(() {
                      _selectedService = service['name']!;
                      _selectedTema = service['name']!;  // Atualiza a seleção do tema
                    });
                    _atualizarCampos(service['name']!);  // Atualiza os campos de acordo com a escolha
                  },
                ),
              ),

            const SizedBox(height: 20),

            // Dropdown para selecionar o tema
            if (_selectedService.isNotEmpty)
              DropdownButton<String>(
                value: _selectedTema,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTema = newValue!;
                  });
                  _atualizarCampos(newValue!);  // Atualiza os campos ao mudar o tema
                },
                items: _services.map<DropdownMenuItem<String>>((service) {
                  return DropdownMenuItem<String>(
                    value: service['name'],
                    child: Text(service['name']!),
                  );
                }).toList(),
              ),

            const SizedBox(height: 20),

            // Campo de Nome do Pedido
            TextField(
              controller: _pedidoController,
              decoration: InputDecoration(
                labelText: 'Nome do Pedido',
                labelStyle: TextStyle(color: Colors.deepPurple),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campo de Quantidade
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(
                labelText: 'Quantidade',
                labelStyle: TextStyle(color: Colors.deepPurple),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Campo de Descrição
            const Text(
              'Descrição do Pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descricaoController,
              maxLines: 4, // Ajustando o tamanho para uma caixa média
              decoration: InputDecoration(
                hintText: 'Descreva o pedido detalhadamente...',
                labelStyle: TextStyle(color: Colors.deepPurple),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Campo de Preço (dinâmico com base no tema)
            const Text(
              'Preço do Pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(
                hintText: 'Preço do serviço...',
                labelStyle: TextStyle(color: Colors.deepPurple),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: false, // Desabilita o campo para edição
            ),
            const SizedBox(height: 20),

            // Botão Adicionar Pedido
            Center(
              child: ElevatedButton(
                onPressed: _adicionarPedido,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Adicionar Pedido',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Página de perfil
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.deepPurple, // Cor personalizada para o AppBar
        elevation: 0,
      ),
      body: SingleChildScrollView( // Permite rolagem caso o conteúdo ultrapasse o espaço
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de imagem de perfil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://www.example.com/profile_image.jpg', // Substitua com a URL da imagem do perfil
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Título com estilo melhorado
            const Text(
              'Bem-vindo ao seu perfil!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, // Cor personalizada para o título
              ),
            ),
            const SizedBox(height: 20),

            // Informações de perfil com mais destaque
            const Text(
              'Nome: João Silva',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87, // Cor para o texto
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: joao.silva@exemplo.com',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Telefone: (11) 98765-4321',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Endereço: Rua Exemplo, 123 - São Paulo, SP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),

            // Seção de status ou biografia
            const Text(
              'Biografia:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sou um desenvolvedor apaixonado por tecnologia e jogos. Adoro aprender novas linguagens de programação e trabalhar em projetos desafiadores.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),

            // Botão de edição de perfil
            ElevatedButton(
              onPressed: () {
                // Adicionar lógica de edição de perfil
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Cor personalizada
                padding: EdgeInsets.symmetric(vertical: 12), // Ajusta o padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Borda arredondada
                ),
              ),
              child: const Text(
                'Editar Perfil',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Cor do texto branca
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Pagina de configuraçoes
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'pt_BR';
  String _theme = 'light';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Carregar as preferências de configurações do SharedPreferences
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _selectedLanguage = prefs.getString('selectedLanguage') ?? 'pt_BR';
      _theme = prefs.getString('theme') ?? 'light';
    });
  }

  // Salvar as preferências de configurações no SharedPreferences
  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
    prefs.setString('selectedLanguage', _selectedLanguage);
    prefs.setString('theme', _theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Configurações da conta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Seção para notificações
            SwitchListTile(
              title: const Text('Notificações', style: TextStyle(color: Colors.black)),
              subtitle: const Text('Ative ou desative as notificações da conta.', style: TextStyle(color: Colors.black)),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _savePreferences();
              },
            ),
            const SizedBox(height: 20),

            // Seção de idioma
            const Text(
              'Idioma',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              items: const [
                DropdownMenuItem<String>(
                  value: 'pt_BR',
                  child: Text('Português (Brasil)', style: TextStyle(color: Colors.black)),
                ),
                DropdownMenuItem<String>(
                  value: 'en_US',
                  child: Text('English', style: TextStyle(color: Colors.black)),
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                _savePreferences();
              },
              decoration: InputDecoration(
                labelText: 'Selecione o idioma',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),

            // Seção de tema
            const Text(
              'Tema',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Modo Claro', style: TextStyle(color: Colors.black)),
              leading: Radio<String>(
                value: 'light',
                groupValue: _theme,
                onChanged: (String? value) {
                  setState(() {
                    _theme = value!;
                  });
                  _savePreferences();
                },
              ),
            ),
            ListTile(
              title: const Text('Modo Escuro', style: TextStyle(color: Colors.black)),
              leading: Radio<String>(
                value: 'dark',
                groupValue: _theme,
                onChanged: (String? value) {
                  setState(() {
                    _theme = value!;
                  });
                  _savePreferences();
                },
              ),
            ),
            const SizedBox(height: 20),

            const Divider(),

            // Informações da Conta
            const Text(
              'Informações da Conta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text('Nome: João Silva', style: TextStyle(color: Colors.black)),
            const Text('Email: joao.silva@exemplo.com', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Lógica para alterar senha
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text('Alterar Senha', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),

            // Gerenciamento de dispositivos
            const Text(
              'Dispositivos Conectados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('iPhone 13 - Último login: 05/12/2024', style: TextStyle(color: Colors.black)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Lógica para desconectar dispositivo
                },
              ),
            ),
            const SizedBox(height: 20),

            // Privacidade e exclusão de conta
            const Text(
              'Privacidade',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Política de Privacidade', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Abrir política de privacidade
              },
            ),
            ListTile(
              title: const Text('Excluir Conta', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Lógica para exclusão de conta
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Lógica para logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Sair da Conta', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// Função para aplicar o tema baseado nas preferências
ThemeData getAppTheme(String theme) {
  if (theme == 'dark') {
    return ThemeData.dark();
  } else {
    return ThemeData.light();
  }
}

// Página de ajuda
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
        backgroundColor: Colors.white, // Cor para o AppBar
        foregroundColor: Colors.black, // Cor do texto no AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Precisa de ajuda? Estamos aqui para isso!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              const Text(
                'Confira as perguntas mais frequentes (FAQ), tutoriais ou entre em contato com nosso suporte.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Seção: Como Funciona?
              const Text(
                'Como Funciona?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nosso serviço conecta você com ... (explique aqui como funciona o sistema ou o app).',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Seção: Perguntas Frequentes
              const Text(
                'Perguntas Frequentes (FAQ)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                '1. Como faço para criar uma conta?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'Resposta: Você pode criar uma conta clicando no botão de "Registrar" no canto superior direito da tela.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. Como posso alterar minhas configurações?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'Resposta: As configurações podem ser alteradas no menu de "Configurações", que fica no canto inferior esquerdo.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. Como posso recuperar minha senha?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'Resposta: Você pode recuperar sua senha clicando no link "Esqueci minha senha" na tela de login.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Seção: Tutoriais
              const Text(
                'Tutoriais Rápidos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.play_circle_outline, color: Colors.black),
                title: const Text(
                  'Como usar o aplicativo?',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  // Abrir vídeo/tutorial
                },
              ),
              ListTile(
                leading: const Icon(Icons.play_circle_outline, color: Colors.black),
                title: const Text(
                  'Dicas para aproveitar ao máximo nossos serviços',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  // Abrir vídeo/tutorial
                },
              ),
              const SizedBox(height: 20),

              // Seção: Links Úteis
              const Text(
                'Links Úteis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.link, color: Colors.black),
                title: const Text(
                  'Termos e Condições',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  // Navegar para página de Termos
                },
              ),
              ListTile(
                leading: const Icon(Icons.link, color: Colors.black),
                title: const Text(
                  'Política de Privacidade',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  // Navegar para página de Política
                },
              ),
              const SizedBox(height: 20),

              // Botão para Contato
              ElevatedButton(
                onPressed: () {
                  // Navegar para página de contato ou abrir suporte
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Contato com Suporte',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // Seção: Abrir Ticket
              const Text(
                'Ainda com dúvidas?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navegar para página de abertura de ticket
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Abrir Ticket de Suporte',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Caso você tenha outras dúvidas, nossa equipe de suporte está disponível 24/7 para ajudar!',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Dashboard do Cliente
class DashboardCliente extends StatelessWidget {
  const DashboardCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área do Cliente'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              logout();

              // Redireciona para a página de login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Perfil') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              } else if (value == 'Configurações') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              } else if (value == 'Ajuda') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Ajuda', 'Configurações', 'Perfil'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Área superior com informações do cliente
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[100],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bem-vindo, [Nome do Cliente]',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Você tem 3 pedidos pendentes'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Área de botões do dashboard
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildDashboardButton(
                  icon: Icons.pending_actions,
                  label: 'Pedidos Pendentes',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PendingOrdersPage()),
                    );
                  },
                ),
                _buildDashboardButton(
                  icon: Icons.check_circle,
                  label: 'Pedidos Concluídos',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CompletedOrdersPage()),
                    );
                  },
                ),
                _buildDashboardButton(
                  icon: Icons.chat,
                  label: 'Chat com o PRO',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    );
                  },
                ),
                _buildDashboardButton(
                  icon: Icons.add_box, // Ícone de adicionar pedido
                  label: 'Adicionar Pedido',
                  color: Colors.green,
                  onTap: () {
                    // Navega para a página de adicionar pedido
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdicionarPedidoPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: color,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: const DashboardCliente(),
    ),
  );
}


