import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  deleteUserVideo(int vId, int uId) async {
    Database? db = await DatabaseHelper().db;

    await db!.delete('user_video',
        where: 'videoid = ? AND userid = ?', whereArgs: [vId, uId]);
    await db.delete('video', where: 'id = ?', whereArgs: [vId]);
  }

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    print(databasesPath);
    String path = join(databasesPath, 'mydatabase.db');

    bool databaseExists = await databaseFactory.databaseExists(path);
    if (!databaseExists) {
      // Se o banco de dados não existir, crie-o e realize as operações de criação das tabelas
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE user(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              email TEXT NOT NULL,
              password TEXT NOT NULL
            )''');

          await db.execute('''CREATE TABLE genre(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL
            )''');

          await db.execute('''CREATE TABLE video(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              description TEXT NOT NULL,
              type INTEGER NOT NULL,
              ageRestriction TEXT NOT NULL,
              durationMinutes INTEGER NOT NULL,
              thumbnailImageId TEXT NOT NULL,
              releaseDate TEXT NOT NULL
            )''');

          await db.execute('''CREATE TABLE video_genre(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              videoid INTEGER NOT NULL,
              genreid INTEGER NOT NULL,
              FOREIGN KEY(videoid) REFERENCES video(id),
              FOREIGN KEY(genreid) REFERENCES genre(id)
            )''');

          await db.execute('''CREATE TABLE user_video(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              userid INTEGER NOT NULL,
              videoid INTEGER NOT NULL,
              FOREIGN KEY(userid) REFERENCES user(id),
              FOREIGN KEY(videoid) REFERENCES video(id)
            )''');
        },
      );
    } else {
      // Se o banco de dados já existir, abra-o
      _db = await openDatabase(path, version: 1);
    }

    return _db!;
  }
}
