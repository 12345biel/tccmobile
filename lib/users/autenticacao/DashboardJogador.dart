import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardJogador extends StatelessWidget {
  const DashboardJogador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              iconSize: 24,
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onChanged: (value) {
                if (value == 'Perfil') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PerfilPage()),
                  );
                } else if (value == 'Configurações') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfiguracoesPage()),
                  );
                } else if (value == 'Ajuda') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AjudaPage()),
                  );
                }
              },
              items: const [
                DropdownMenuItem(value: 'Perfil', child: Text('Perfil')),
                DropdownMenuItem(value: 'Configurações', child: Text('Configurações')),
                DropdownMenuItem(value: 'Ajuda', child: Text('Ajuda')),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () {
              // Ação de logout
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              const SizedBox(height: 20),
              _buildNavigationSection(context),
              const SizedBox(height: 20),
              _buildSingleServiceSection(),
              const SizedBox(height: 20),
              _buildSingleWithdrawSection(),
              const SizedBox(height: 20),
              _buildFeedbackSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Nome do Jogador',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nível 10 | XP: 2000',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildStatsChart(),
        ],
      ),
    );
  }

  Widget _buildStatsChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.green,
                  width: 15,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 8,
                  color: Colors.orange,
                  width: 15,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 7,
                  color: Colors.blue,
                  width: 15,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSection(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.list_alt, color: Colors.orange),
          title: const Text('Serviços', style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ServicePage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.attach_money, color: Colors.green),
          title: const Text('Saque', style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WithdrawPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.chat, color: Colors.blue),
          title: const Text('Chat com o Cliente', style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSingleServiceSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Serviço Atual',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildServiceItem('Serviço 1', 'DuoBoosting, Aumente seu elo jogando com um parceiro experiente'),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String description) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Text(description, style: const TextStyle(color: Colors.white70)),
      trailing: IconButton(
        icon: const Icon(Icons.check_circle, color: Colors.greenAccent),
        onPressed: () {
          // Ação para marcar como concluído ou iniciar serviço
        },
      ),
    );
  }

  Widget _buildSingleWithdrawSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saque Atual',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildWithdrawItem('Saldo disponível', 'R\$ 1000,00'),
        ],
      ),
    );
  }

  Widget _buildWithdrawItem(String title, String amount) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      trailing: Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildFeedbackSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Comentário de Cliente',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            '“Excelente atendimento! O jogador foi muito ágil e prestativo, recomendo a todos!”',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// Páginas vazias (Perfil, Configurações, Ajuda)
// Página de Perfil com conteúdo real
class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nome do Jogador',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nível 10 | XP: 2000',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildProfileDetail('E-mail', 'email@exemplo.com'),
            _buildProfileDetail('Telefone', '(11) 98765-4321'),
            _buildProfileDetail('Endereço', 'Rua Exemplo, 123, São Paulo, SP'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          Text(value, style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}

// Página de Configurações
class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingOption('Notificações', true),
            _buildSettingOption('Modo Escuro', false),
            _buildSettingOption('Idioma', 'Português'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          value is bool
              ? Switch(value: value, onChanged: (newValue) {})
              : Text(value, style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}

// Página de Ajuda
class AjudaPage extends StatelessWidget {
  const AjudaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajuda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Como usar o aplicativo?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Aqui você pode aprender a navegar no nosso aplicativo e tirar dúvidas sobre funcionalidades.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            _buildHelpItem('Como mudar meu perfil?', 'Vá até a página de perfil e clique em Editar.'),
            _buildHelpItem('Como fazer saque?', 'Vá até a página de saque e insira o valor desejado.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação de entrar em contato com o suporte
              },
              child: const Text('Entrar em contato com o Suporte'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(answer, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}

// Página de Serviços (com a adição dos serviços)
class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
      ),
      body: ListView(
        children: [
          _buildServiceTile(
            'EloBoosting',
            'Melhore seu ranking com um boost de elo personalizado.',
            Icons.arrow_upward,
          ),
          _buildServiceTile(
            'DuoBoosting',
            'Aumente seu elo jogando com um parceiro experiente.',
            Icons.group,
          ),
          _buildServiceTile(
            'Coach',
            'Receba dicas e treinos personalizados de um coach profissional.',
            Icons.school,
          ),
        ],
      ),
    );
  }

  // Método para construir cada item da lista de serviços
  Widget _buildServiceTile(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Aqui você pode adicionar a lógica de navegação ou ação
        },
      ),
    );
  }
}

// Página de Saque (branca)
class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  double availableBalance = 1000.00; // Saldo disponível inicial
  String message = '';

  // Função para realizar o saque
  void _processWithdraw() {
    double amountToWithdraw = double.tryParse(_amountController.text) ?? 0.0;

    if (amountToWithdraw <= 0) {
      setState(() {
        message = 'Por favor, insira um valor válido para o saque.';
      });
    } else if (amountToWithdraw > availableBalance) {
      setState(() {
        message = 'Saldo insuficiente para realizar o saque.';
      });
    } else {
      setState(() {
        availableBalance -= amountToWithdraw;
        message = 'Saque de R\$ $amountToWithdraw realizado com sucesso!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saque'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe o saldo disponível
            Text(
              'Saldo disponível: R\$ ${availableBalance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Campo para inserir o valor do saque
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor do Saque',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Botão para processar o saque
            ElevatedButton(
              onPressed: _processWithdraw,
              child: const Text('Realizar Saque'),
            ),
            const SizedBox(height: 20),

            // Mensagem de feedback
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de Chat (branca)
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat com o Cliente'),
        backgroundColor: Colors.purple.shade700, // Cor de fundo da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Área de mensagens
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Limita para 5 clientes
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/avatar.png'), // Foto do cliente
                      // Se a imagem não for encontrada, exibe um ícone padrão
                      child: Icon(
                        Icons.person,
                        color: Colors.black26,
                        size: 30, // Ajuste o tamanho do ícone conforme necessário
                      ),
                    ),
                    title: Text(
                      'Cliente ${index + 1}', // Nome do cliente (1 a 5)
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Mensagem número $index', style: const TextStyle(color: Colors.black54)),
                  );
                },
              ),
            ),

            // Campo de digitação
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite sua mensagem...',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.purple),
                    onPressed: () {
                      // Enviar mensagem
                      print('Mensagem enviada!');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


