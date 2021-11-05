import 'package:brinquedoar_flutter/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dao {
  get_db() async{
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "db.db");

    var database = await openDatabase(localBD, version: 1, onCreate: (db, dbVersaoRecente){
        String sql = "CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, bio VARCHAR, email VARCHAR, senha VARCHAR, isONG INTEGER)";
        print("TABELA CRIADA " + localBD.toString());
        db.execute(sql);
      }
    );

    print("Is open: " + database.isOpen.toString());

    return database;
  }

  insertUser(Map<String, dynamic> userData) async {
    Database db = await get_db();

    return await db.insert("User", userData);
  }

  getUserByEmail(String email) async{
    Database db = await get_db();

    List query = await db.query(
        "User",
        columns: ["id", "nome", "email", "senha", "isONG"],
        where: "email = ?",
        whereArgs: [email]);

    return User.fromQuery(query[0]);
  }


}