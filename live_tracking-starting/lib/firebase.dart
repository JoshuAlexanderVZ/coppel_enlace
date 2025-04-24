import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'usuarios.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            apellido TEXT NOT NULL,
            contrasena TEXT NOT NULL,
            confirmar_contrasena TEXT NOT NULL,
            codigo_postal TEXT NOT NULL,
            tipo_cliente TEXT NOT NULL,
            telefono TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertarUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    await db.insert(
      'usuarios',
      usuario,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> obtenerUltimoUsuario() async {
    final db = await database;
    final resultado = await db.query('usuarios', orderBy: 'id DESC', limit: 1);
    return resultado.isNotEmpty ? resultado.first : null;
  }
}