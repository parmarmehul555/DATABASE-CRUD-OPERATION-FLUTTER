import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "User.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'create table person(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)');
      },
    );
  }

  Future<List<Map<String,dynamic>>> getAllData() async{
    Database db = await initDatabase();
    var data = await db.rawQuery('select * from person');
    return data;
  }

  Future<int> addUser(Map<String,dynamic> map) async {
    Database db = await initDatabase();
    int res = await db.insert('person', map);
    return res;
  }

  Future<int> editUser(Map<String,dynamic> map,id) async{
    Database db = await initDatabase();
    int res = await db.update('person', map,where: "id = ?",whereArgs: [id]);
    return res;
  }

  Future<void> deleteUser(id)async {
    Database db = await initDatabase();
    await db.delete('person',where: "id = ?",whereArgs: [id]);
  }
}
