import 'package:cinebox/models/movies.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DbHelper {
  static const dbName = 'cineboxv1.db';
  static const dbVersion = 1;
  static const tableName = 'movies';
  static const colTitle = 'movieTitle';
  static const colGenre = 'movieGenre';
  static const colStatus = 'movieStatus';
  static const colDescription = 'movieDescription';
  static const colImageUrl = 'movieImageUrl';

  late Database _database;
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT NOT NULL,
        $colGenre TEXT NOT NULL,
        $colStatus TEXT NOT NULL,
        $colDescription TEXT,
        $colImageUrl TEXT
      )
    ''');
  }

  Future<int> insertMovie(MovieDetails movie) async {
    final db = await database;
    return await db.insert('movies', movie.toMap());
  }

  Future<List<MovieDetails>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return MovieDetails.fromMap(maps[i]);
    });
  }

  Future<int> updateMovie(int id, String status) async {
    final db = await database; // Assuming a database getter is defined
    return db.update(
      'movies',
      {'movieStatus': status}, // Update only the status
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMovie(int id) async {
    Database db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
