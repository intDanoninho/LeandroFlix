import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager{

  DatabaseManager._();

  static final DatabaseManager instance = DatabaseManager._();

  static Database? _db;
   get database async{
     if (_db!=null) return _db;

     return await _initDatabase();
   }

   _initDatabase() async{

    return await openDatabase(
      join(await getDatabasesPath(), 'banco.db'),
      version: 1,
      onCreate: (db, version) async {
    // Cria as tabelas
      String sql ="""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR NOT NULL,
        email VARCHAR NOT NULL,
        password VARCHAR NOT NULL
      );

      CREATE TABLE genre(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR NOT NULL
      );

      CREATE TABLE video(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(2) NOT NULL,
        description TEXT NOT NULL,
        type INTEGER NOT NULL,
        ageRestriction VARCHAR NOT NULL,
        durationMinutes INTEGER NOT NULL,
        thumbnailImageId VARCHAR NOT NULL,
        releaseDate TEXT NOT NULL
      );

      CREATE TABLE video_genre(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        videoid INTEGER NOT NULL,
        genreid INTEGER NOT NULL,
        FOREIGN KEY(videoid) REFERENCES video(id),
        FOREIGN KEY(genreid) REFERENCES genre(id)
      );
    """;
      await db.execute(sql);
    }
    );
  }
}