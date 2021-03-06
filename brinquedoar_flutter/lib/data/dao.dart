import 'package:brinquedoar_flutter/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:path/path.dart';

class SqlTypes {
  static String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static String string = 'VARCHAR NOT NULL';
}

const tablesName = ['user', 'donations'];

class dao {
  static get_db() async {
    final caminhoBD = await getDatabasesPath();
    final localBD = join(caminhoBD, "db.db");

    await deleteDatabase(caminhoBD);

    var database = await openDatabase(localBD, version: 1,
        onCreate: (db, dbVersaoRecente) {
      var sql = '''
        CREATE TABLE ${tablesName[0]} (id ${SqlTypes.idType}, nome ${SqlTypes.string}, email ${SqlTypes.string}, senha ${SqlTypes.string}, isONG INTEGER);      
          ''';

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
            ${TableDoacao.url_imagem} ${SqlTypes.string},
            FOREIGN KEY(user) REFERENCES ${tablesName[0]}(id)  
            );
        ''';
      db.execute(sql);

      db.execute(
          "CREATE TABLE pedido (id INTEGER PRIMARY KEY AUTOINCREMENT, id_user INTEGER NOT NULL, status VARCHAR, descricao VARCHAR, FOREIGN KEY (id_user) REFERENCES user (id));");
    });

    print("Is open: " + database.isOpen.toString());

    return database;
  }

  /// TODO: RETIRAR ESSA PARTE DE CODIGO E COLOCAR DINAMICO
  _salvarDados() async {
    Database bd = await get_db();

    Map<String, dynamic> dadosUsuario = {
      "nome": 'Diogo',
      "email": 'diogo@hotmail.com',
      "senha": '2',
      "isOng": '0'
    };

    int id = await bd.insert("user", dadosUsuario);
    //print(id);

    Map<String, dynamic> pedidoUsuario = {
      "id_user": id,
      "status": 'Em Andamento',
      "descricao": 'Brinquedo'
    };

    int idPedido = await bd.insert("pedido", pedidoUsuario);
  }

  getPedidosById(int? idUser) async {
    Database db = await get_db();

    /// TODO: RETIRAR ESSA PARTE DE CODIGO E COLOCAR DINAMICO
    _salvarDados();

    List query = await db.query("pedido",
        columns: ["id", "status", "descricao"],
        where: "id_user = ?",
        whereArgs: [idUser]);

    return query;
  }

  insertPdido(Map<String, dynamic> pedidoData) async {
    Database db = await get_db();

    return await db.insert("pedido", pedidoData);
  }

  static close() async {
    Database db = await get_db();
    db.close();
  }

  // User
  insertUser(Map<String, dynamic> userData) async {
    Database db = await get_db();

    return await db.insert(tablesName[0], userData);
  }

  getUserByEmail(String email) async {
    Database db = await get_db();

    List query = await db.query("User",
        columns: ["id", "nome", "email", "senha", "isONG"],
        where: "email = ?",
        whereArgs: [email]);

    return User.fromQuery(query[0]);
  }

  // Donatios
  getDonationsById(int user) async {
    Database db = await get_db();
    var result = await db.query(tablesName[1], where: "user = ?", whereArgs: [
      user
    ], columns: [
      "_id",
      "titulo",
      "descricao",
      "enderecoRua",
      "enderecoBairro",
      "estado",
      "numero",
      "user",
      "url_imagem"
    ]);

    return result;
  }

  getAllDonations(int? id) async{
    Database db = await get_db();
    var result;

    if (id != null) {
      result = await db.query(tablesName[1], where: "user != ?", whereArgs: [
        id
      ], columns: [
        "_id",
        "titulo",
        "descricao",
        "enderecoRua",
        "enderecoBairro",
        "estado",
        "numero",
        "user",
        "url_imagem"
      ]);
    }
    else{
      result = await db.query(tablesName[1], columns: [
        "_id",
        "titulo",
        "descricao",
        "enderecoRua",
        "enderecoBairro",
        "estado",
        "numero",
        "user",
        "url_imagem"
      ]);
    }

    return result;
  }

  deleteDonation(int id) async{
    Database db = await get_db();

    print(id);

    var result = await db.delete(tablesName[1], where: "_id = ?", whereArgs: [id]);

    return result;
  }
}
