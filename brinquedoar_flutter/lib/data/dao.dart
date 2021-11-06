import 'package:brinquedoar_flutter/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dao {
  get_db() async{
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "db.db");

    await deleteDatabase(caminhoBD);

    var database = await openDatabase(localBD, version: 1, onCreate: (db, dbVersaoRecente){
        _createDb(db, dbVersaoRecente);
      }
    );

    print("Is open: " + database.isOpen.toString());

    return database;
  }

  /// TODO: RETIRAR ESSA PARTE DE CODIGO E COLOCAR DINAMICO
  _salvarDados() async {
    Database bd = await get_db();

    Map<String, dynamic> dadosUsuario = {
      "nome" : 'Diogo',
      "email" : 'diogo@hotmail.com',
      "senha" : '2',
      "isOng" : '0'
    };

    int id = await bd.insert("user", dadosUsuario);
    //print(id);

    Map<String, dynamic> pedidoUsuario = {
      "id_user" : id,
      "status" : 'Em Andamento',
      "descricao" : 'Brinquedo'
    };

    int idPedido = await bd.insert("pedido", pedidoUsuario);
  }

  getPedidosById(int? idUser) async {
    Database db = await get_db();

    /// TODO: RETIRAR ESSA PARTE DE CODIGO E COLOCAR DINAMICO
    _salvarDados();

    List query = await db.query(
        "pedido",
        columns: ["id", "status", "descricao"],
        where: "id_user = ?",
        whereArgs: [idUser]
    );

    return query;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, email VARCHAR, senha VARCHAR, bio VARCHAR, isONG INTEGER);");
    await db.execute("CREATE TABLE pedido (id INTEGER PRIMARY KEY AUTOINCREMENT, id_user INTEGER NOT NULL, status VARCHAR, descricao VARCHAR, FOREIGN KEY (id_user) REFERENCES user (id));");
  }

  insertUser(Map<String, dynamic> userData) async {
    Database db = await get_db();

    return await db.insert("user", userData);
  }

  insertPdido(Map<String, dynamic> pedidoData) async {
    Database db = await get_db();

    return await db.insert("pedido", pedidoData);
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