import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'login.dart';
import 'dart:math';

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
              // Navega para a página de login e remove todas as páginas anteriores
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
              );
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
    // Variável representando a pontuação do jogador, de 0 a 5 estrelas.
    int playerScore = 4;  // Exemplo de pontuação (pode ser dinâmico)

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
                children: [
                  // Nome do jogador
                  const Text(
                    'Nome do Jogador',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8), // Espaço entre o nome e as estrelas
                  // Exibe as estrelas com base na pontuação
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        color: index < playerScore ? Colors.yellow : Colors.grey, // Muda a cor conforme a pontuação
                        size: 30, // Tamanho maior da estrela
                      );
                    }),
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

// Página de Perfil
class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
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
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildProfileDetail('E-mail', 'email@exemplo.com'),
              _buildProfileDetail('Telefone', '(11) 98765-4321'),
              _buildProfileDetail('Endereço', 'Rua Exemplo, 123, São Paulo, SP'),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Biografia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Jogador apaixonado por games de estratégia e aventura. Sempre em busca de desafios épicos e novas conquistas.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Conquistas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildAchievement('🏆 Mestre dos Puzzles', 'Concluiu 100 desafios de lógica.'),
              _buildAchievement('🥇 Explorador Lendário', 'Desbloqueou todas as áreas secretas em 3 jogos.'),
              _buildAchievement('⚔️ Herói de Batalhas', 'Venceu 500 partidas online.'),
              const SizedBox(height: 20),
              const Text(
                'Jogos Favoritos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildFavoriteGame('🎮 The Legend of Zelda'),
              _buildFavoriteGame('🎮 Final Fantasy XIV'),
              _buildFavoriteGame('🎮 League of Legends'),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Ação ao pressionar o botão de editar perfil
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar Perfil'),
                ),
              ),
            ],
          ),
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

  Widget _buildAchievement(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteGame(String game) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.videogame_asset, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            game,
            style: const TextStyle(fontSize: 16),
          ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Conta',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSettingOption('Alterar E-mail', 'email@exemplo.com'),
              _buildSettingOption('Alterar Senha', '********'),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Preferências',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSettingOption('Notificações', true),
              _buildSettingOption('Modo Escuro', false),
              _buildSettingOption('Idioma', 'Português'),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Outros',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSettingOption('Política de Privacidade', ''),
              _buildSettingOption('Termos de Serviço', ''),
              _buildSettingOption('Sobre o App', 'Versão 1.0.0'),
            ],
          ),
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
              ? Switch(
            value: value,
            onChanged: (newValue) {
              // Lógica ao alterar a configuração
            },
          )
              : GestureDetector(
            onTap: () {
              // Lógica para redirecionar ou editar as opções de texto
            },
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
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
        child: ListView(
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

            // Botão para "Como mudar meu perfil"
            _buildHelpItemWithButton(
              context,
              'Como mudar meu perfil?',
              'Vá até a página de perfil e clique em Editar.',
                  () => Navigator.pushNamed(context, '/perfil'),
            ),

            // Botão para "Como fazer saque"
            _buildHelpItemWithButtonForWithdraw(
              context,
              'Como fazer saque?',
              'Vá até a página de saque e insira o valor desejado.',
                  () => Navigator.pushNamed(context, '/saque'),
            ),

            // Outros itens de ajuda sem botão
            _buildHelpItem(
              'Como gerenciar pedidos?',
              'Acesse a aba "Pedidos Pendentes" para visualizar solicitações. Após concluir, mova para "Pedidos Concluídos".',
            ),
            _buildHelpItem(
              'Onde vejo minhas estatísticas?',
              'Na página de perfil, você pode visualizar seu nível, XP acumulado e estatísticas de desempenho.',
            ),
            _buildHelpItem(
              'Como ativar notificações?',
              'Na página de configurações, ative a opção "Notificações" para receber alertas importantes.',
            ),
            _buildHelpItem(
              'Como trocar o idioma do aplicativo?',
              'Na página de configurações, clique em "Idioma" e escolha o idioma desejado.',
            ),
            _buildHelpItem(
              'O que fazer em caso de erros?',
              'Tente reiniciar o aplicativo. Se o problema persistir, entre em contato com o suporte técnico.',
            ),
            _buildHelpItem(
              'Como atualizar o aplicativo?',
              'Visite a loja de aplicativos do seu dispositivo e verifique se há uma nova versão disponível para download.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItemWithButton(BuildContext context, String question, String answer, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Cor do texto alterada para branco
          ),
          const SizedBox(height: 5),
          Text(
            answer,
            style: const TextStyle(fontSize: 16, color: Colors.black), // Cor do texto alterada para branco
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Navegação direta para a página de perfil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Cor do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas
              ),
            ),
            child: const Text(
              'Ir para a página',
              style: TextStyle(color: Colors.white), // Cor do texto do botão alterada para branco
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItemWithButtonForWithdraw(BuildContext context, String question, String answer, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Cor do texto alterada para branco
          ),
          const SizedBox(height: 5),
          Text(
            answer,
            style: const TextStyle(fontSize: 16, color: Colors.black), // Cor do texto alterada para branco
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Navegação direta para a página de saque
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WithdrawPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Cor do botão de saque
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas
              ),
            ),
            child: const Text(
              'Ir para o saque',
              style: TextStyle(color: Colors.white), // Cor do texto do botão alterada para branco
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildHelpItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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

// Página de Serviços Jogador
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
            context,
            'EloBoosting',
            'Melhore seu ranking com um boost de elo personalizado. Escolha seu elo atual e o elo desejado, e deixe o nosso time de especialistas ajudar você a alcançar sua meta.',
            Icons.arrow_upward,
          ),
          _buildServiceTile(
            context,
            'DuoBoosting',
            'Aumente seu elo jogando com um parceiro experiente. Você será emparelhado com um jogador profissional que ajudará você a melhorar sua jogabilidade.',
            Icons.group,
          ),
          _buildServiceTile(
            context,
            'Coach',
            'Receba dicas e treinos personalizados de um coach profissional. Acompanhamento individual para aprimorar suas habilidades específicas e estratégias no jogo.',
            Icons.school,
          ),
        ],
      ),
    );
  }

  // Método para construir cada item da lista de serviços
  Widget _buildServiceTile(
      BuildContext context,
      String title,
      String description,
      IconData icon,
      ) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 10),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Lógica para navegar para a página de pedidos do serviço
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceOrdersPage(serviceName: title),
            ),
          );
        },
      ),
    );
  }
}

class ServiceOrdersPage extends StatelessWidget {
  final String serviceName;

  const ServiceOrdersPage({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    // Aqui você pode usar uma lista de pedidos dependendo do serviço
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos de $serviceName'),
      ),
      body: ListView(
        children: [
          _buildOrderTile(serviceName, 'Pedido #1', 'Em andamento', Icons.access_time, context),
          _buildOrderTile(serviceName, 'Pedido #2', 'Concluído', Icons.check_circle, context),
          _buildOrderTile(serviceName, 'Pedido #3', 'Pendente', Icons.pending, context),
          // Adicione mais pedidos conforme necessário
        ],
      ),
    );
  }

  Widget _buildOrderTile(String serviceName, String orderTitle, String status, IconData icon, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(orderTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navega para a página de chat com o cliente ao clicar em um pedido
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(),
            ),
          );
        },
      ),
    );
  }
}

// Página de Saque
class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _depositPathController = TextEditingController(); // Caminho do Depósito
  double availableBalance = 1000.00; // Saldo disponível inicial
  String message = '';
  List<String> withdrawalHistory = []; // Lista para armazenar o histórico de saques

  List<String> recentWithdrawals = []; // Armazenar os dois últimos saques

  // Função para realizar o saque
  void _processWithdraw() {
    double amountToWithdraw = double.tryParse(_amountController.text) ?? 0.0;
    String depositPath = _depositPathController.text;

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
        String newWithdrawal = 'Saque de R\$ $amountToWithdraw, Caminho: $depositPath';
        // Adiciona ao início da lista de saques recentes
        if (recentWithdrawals.length == 2) {
          recentWithdrawals.removeLast(); // Remove o saque mais antigo
        }
        recentWithdrawals.insert(0, newWithdrawal); // Adiciona o novo saque

        // Adiciona ao histórico, excluindo os 2 saques mais recentes
        withdrawalHistory.insert(0, newWithdrawal);

        message = 'Saque de R\$ $amountToWithdraw realizado com sucesso!';
      });
    }
  }

  // Função para mostrar o histórico de saques
  void _showWithdrawalHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Histórico de Saques'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: withdrawalHistory.isNotEmpty
                ? withdrawalHistory.map((history) => Text(history)).toList()
                : [const Text('Nenhum saque realizado ainda.')],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Função para adicionar saques aleatórios
  void _generateRandomWithdrawals() {
    final random = Random();
    List<String> randomWithdrawals = [];
    for (int i = 0; i < 5; i++) {
      double randomAmount = random.nextInt(500) + 50.0; // valores entre R$ 50 e R$ 550
      String randomDepositPath = 'Banco #${i + 1}';
      randomWithdrawals.add('Saque de R\$ $randomAmount, Caminho: $randomDepositPath');
    }
    setState(() {
      withdrawalHistory = randomWithdrawals; // Substitui a lista com os saques aleatórios
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomWithdrawals(); // Gerar saques aleatórios ao iniciar a página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saque'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showWithdrawalHistory,
          ),
        ],
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

            // Campo para inserir o caminho do depósito
            TextField(
              controller: _depositPathController,
              decoration: const InputDecoration(
                labelText: 'Caminho do Depósito',
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

            const SizedBox(height: 20),

            // Exibe os dois saques mais recentes
            if (recentWithdrawals.isNotEmpty)
              ...recentWithdrawals.map((withdrawal) => Text(
                'Último Saque: $withdrawal',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          ],
        ),
      ),
    );
  }
}

// Página de Chat com o Cliente
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
                'Cliente ${index + 1}', // Nome do jogador (1 a 4)
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Clique para iniciar o chat',
                style: const TextStyle(color: Colors.black54),
              ),
              onTap: () {
                // Ao clicar no jogador, abre a tela de chat privado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatWithClientPage(playerIndex: index),
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

class ChatWithClientPage extends StatefulWidget {
  final int playerIndex;

  const ChatWithClientPage({required this.playerIndex, super.key});

  @override
  _ChatWithClientPageState createState() => _ChatWithClientPageState();
}

class _ChatWithClientPageState extends State<ChatWithClientPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    // Inicializa as mensagens com base no índice do jogador
    _messages = [
      'Jogador ${widget.playerIndex + 1}: Olá, como posso ajudar você?',
      'Cliente: Oi, estou com uma dúvida!',
    ];
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add('Jogador ${widget.playerIndex + 1}: ${_controller.text}');
        _messages.add('Cliente: Resposta automática!');
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
        title: Text('Chat com Cliente ${widget.playerIndex + 1}'),
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
                bool isClientMessage = message.startsWith('Cliente');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Align(
                    alignment: isClientMessage ? Alignment.topLeft : Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isClientMessage ? Colors.grey.shade200 : Colors.blue.shade100,
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
                          color: isClientMessage ? Colors.black : Colors.blue.shade900,
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




