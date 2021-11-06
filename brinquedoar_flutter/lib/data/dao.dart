import 'package:brinquedoar_flutter/model/docao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlTypes{
  static String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static String string = 'VARCHAR NOT NULL';
}
 const tablesName = ['user','donations'];
class dao {

  static get_db() async{
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "db.db");

    var database = await openDatabase(localBD, version: 1, onCreate: (db, dbVersaoRecente){ 
        var sql = '''
        CREATE TABLE ${tablesName[0]} (id ${SqlTypes.idType}, nome ${SqlTypes.string}, email ${SqlTypes.string}, senha ${SqlTypes.string}, isONG INTEGER);      
          ''';
        print("TABELA CRIADA " + localBD.toString());
        db.execute(sql);

        sql = '''
        CREATE TABLE ${tablesName[1]} (
            ${TableDoacao.id} ${SqlTypes.idType}, 
            ${TableDoacao.user} INTEGER,
            ${TableDoacao.titulo} ${SqlTypes.string}, 
            ${TableDoacao.descricao} ${SqlTypes.string}, 
            ${TableDoacao.enderecoRua} ${SqlTypes.string}, 
            ${TableDoacao.enderecoBairro} ${SqlTypes.string},
            ${TableDoacao.numero} ${SqlTypes.string},
            ${TableDoacao.estado} ${SqlTypes.string},
            FOREIGN KEY(user) REFERENCES ${tablesName[0]}(id)  
            );
        ''';
        db.execute(sql);
      }
    );

    print("Is open: " + database.isOpen.toString());

    return database;
  }

  static close() async{
    Database db = await get_db();
    db.close();
  }

  // User
  insertUser(Map<String, dynamic> userData) async {
    Database db = await get_db();

    return await db.insert(tablesName[0], userData);
  }

  static getUserByEmail(String email) async{
    Database db = await get_db();

    List query = await db.query(
        "User",
        columns: ["id", "nome", "email", "senha", "isONG"],
        where: "email = ?",
        whereArgs: [email]);

    for(var sla in query){
      print("email: " + sla["email"] + " senha: " + sla["senha"]);
    }

    return query[0];
  }

  // Donatios
  static insertDonations(doacao donation) async {
    Database db = await get_db();
    return await db.insert(tablesName[1], donation.toJSON()); 

  }

  static getAllDonations(int user) async {
    Database db = await get_db();
    return await db.query(
      tablesName[1],
      where: "user = ?", 
      whereArgs: [user],
      columns: ["id", "titulo","descricao", "enderecoRua", "enderecoBairro", "estado", "numero"]
    );
  } 

  // updateDonation(doacao newDonation) async {
  //   Database db = await get_db();
  //   return await db.rawUpdate(
  //   'UPDATE $tablesName[1] SET name = ?, value = ? WHERE id = ? ',
  //   ['updated name', '9876', 'some name']);

  // }
}