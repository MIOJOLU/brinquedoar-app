import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dao {
  get_db() async{
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "db.db");

    var database = await openDatabase(localBD, version: 1, onCreate: (db, dbVersaoRecente){
        String sql = "CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, email VARCHAR, senha VARCHAR, isONG INTEGER);";
        print("TABELA CRIADA " + localBD.toString());

        db.execute(sql);
      }
    );

    print("Is open: " + database.isOpen.toString());

    return database;
  }

  get_pedidos_db() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "db.db");

      var database = await openDatabase(localBD, version: 1, onCreate: (db, dbVersaoRecente){
        String sql = "CREATE TABLE pedido (id INTEGER PRIMARY KEY AUTOINCREMENT, id_user INTEGER NOT NULL, status VARCHAR, descricao VARCHAR, FOREIGN KEY (id_user) REFERENCES user (id));";
        print("TABELA CRIADA " + localBD.toString());

        db.execute(sql);
      }
    );

    print("Is open: " + database.isOpen.toString());

    return database;
  }

  _salvarDados() async {
    Database bd = await get_pedidos_db();

    Map<String, dynamic> dadosUsuario = {
      "nome" : 'Diogo',
      "email" : 'diogo@hotmail.com',""
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

  insertUser(Map<String, dynamic> userData) async {
    Database db = await get_db();

    return await db.insert("User", userData);
  }

  getPedidosById(int? idUser) async {
    Database db = await get_db();

    _salvarDados();

    List query = await db.query(
      "pedido",
      columns: ["id", "status", "descricao"],
      where: "id_user = ?",
      whereArgs: [idUser]
    );

    return query;
  }

  getUserByEmail(String email) async{
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
}