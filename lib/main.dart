import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Boosting Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.indigo,
          titleTextStyle: TextStyle(
            color: Color(0xFFA88A6F),
            fontFamily: 'PressStart2P',
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFFA88A6F),
            fontFamily: 'PressStart2P',
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFA88A6F),
            fontFamily: 'PressStart2P',
          ),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _userType = 'Cliente'; // Valor padrão
  bool _obscurePassword = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      String role = _userType == 'Cliente' ? 'Client' : 'Pro';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(role: role),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Image.asset('assets/logo.png', height: 150),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo para o usuário
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      labelStyle: TextStyle(color: Color(0xFFA88A6F)),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                    ),
                    style: TextStyle(color: Color(0xFFA88A6F)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o usuário';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // Campo para a senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      labelStyle: TextStyle(color: Color(0xFFA88A6F)),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Color(0xFFA88A6F)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // Dropdown para selecionar o tipo de usuário
                  DropdownButtonFormField<String>(
                    value: _userType,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Color(0xFFA88A6F)),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Cliente',
                        child: Text('Cliente', style: TextStyle(color: Color(0xFFA88A6F))),
                      ),
                      DropdownMenuItem(
                        value: 'Jogador',
                        child: Text('Jogador', style: TextStyle(color: Color(0xFFA88A6F))),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione o tipo de usuário';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não tem uma conta? "),
                      GestureDetector(
                        onTap: () {
                          // Navegar para a tela de registro
                        },
                        child: Text(
                          'Registrar',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
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

class DashboardPage extends StatelessWidget {
  final String role;

  DashboardPage({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel do $role'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            tooltip: 'Deslogar',
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: role == 'Client' ? 'Meus Pedidos' : 'Chat com Cliente'),
                Tab(text: role == 'Client' ? 'Chat com o Profissional' : 'Meus Serviços'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  role == 'Client' ? OrdersPage() : ChatPage(), // Página do cliente ou chat
                  role == 'Client' ? ChatPage() : ServicesPage(), // Página do cliente ou serviços
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Aqui você pode gerenciar seus pedidos.'),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Aqui você pode conversar com o cliente.'),
    );
  }
}

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Aqui você pode visualizar e gerenciar seus serviços.'),
    );
  }
}
