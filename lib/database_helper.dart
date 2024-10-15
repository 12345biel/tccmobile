// database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/pedido.dart';
import 'models/servico.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'game_boosting.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE pedidos (
            id TEXT PRIMARY KEY,
            clienteId TEXT,
            status TEXT,
            data TEXT
          )
        ''');
        await db.execute(''' 
          CREATE TABLE servicos (
            id TEXT PRIMARY KEY,
            jogadorId TEXT,
            tipo TEXT,
            status TEXT,
            data TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPedido(Pedido pedido) async {
    final db = await database;
    await db.insert(
      'pedidos',
      pedido.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pedido>> getPedidos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pedidos');
    return List.generate(maps.length, (i) {
      return Pedido.fromMap(maps[i]);
    });
  }

  Future<void> insertServico(Servico servico) async {
    final db = await database;
    await db.insert(
      'servicos',
      servico.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Servico>> getServicos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('servicos');
    return List.generate(maps.length, (i) {
      return Servico.fromMap(maps[i]);
    });
  }

  // Método para fechar o banco de dados
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null; // Define como nulo para indicar que está desconectado
    }
  }
}
