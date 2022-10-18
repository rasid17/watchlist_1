import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/movie.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableMovie';
  final String columnId = 'id';
  final String columnJudul = 'judul';
  final String columnGenre = 'genre';
  final String columnTahun = 'tahun';
  final String columnDurasi = 'durasi';
  final String columnEpisode = 'episode';
  final String columnDone = 'done';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> database() async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDb();
      return _database;
    }
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, tableName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnJudul TEXT, "
        "$columnGenre TEXT,"
        "$columnTahun TEXT,"
        "$columnDurasi TEXT,"
        "$columnEpisode TEXT,"
        "$columnDone TEXT)";
    await db.execute(sql);
  }

  Future<List?> getAllMovie() async {
    var dbClient = await _database;
    print(dbClient);
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnJudul,
      columnGenre,
      columnTahun,
      columnDurasi,
      columnEpisode,
      columnDone
    ]);
    return result.toList();
  }

  Future<List?> getAllMovieDone() async {
    var dbClient = await _database;
    print(dbClient);
    var result =
        await dbClient!.query(tableName, where: '$columnDone = ?', whereArgs: [
      "Sudah"
    ], columns: [
      columnId,
      columnJudul,
      columnGenre,
      columnTahun,
      columnDurasi,
      columnEpisode,
      columnDone
    ]);

    return result.toList();
  }

  Future<List?> getAllMovieNotDone() async {
    var dbClient = await _database;
    print(dbClient);
    var result =
        await dbClient!.query(tableName, where: '$columnDone = ?', whereArgs: [
      "Belum"
    ], columns: [
      columnId,
      columnJudul,
      columnGenre,
      columnTahun,
      columnDurasi,
      columnEpisode,
      columnDone
    ]);

    return result.toList();
  }

  Future<int?> tambahMovie(Movie movie) async {
    var dbClient = await _database;
    return await dbClient!.insert(tableName, movie.toMap());
  }

  Future<int?> updateMovie(Movie movie) async {
    var dbClient = await _database;
    return await dbClient!.update(tableName, movie.toMap(),
        where: '$columnId = ?', whereArgs: [movie.id]);
  }

  Future<int?> updateMovieDone(Movie movie, String status) async {
    var dbClient = await _database;
    return await dbClient!.update(tableName, {'done': status},
        where: '$columnId = ?', whereArgs: [movie.id]);
  }

  Future<int?> hapusMovie(int id) async {
    var dbClient = await _database;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
