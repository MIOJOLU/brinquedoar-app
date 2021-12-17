import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:sqflite/sqflite.dart';

class DoacaoService {
  static const tablesName = ['user', 'donations'];
  static insertDonations(doacao donation) async {
    Database db = await dao.get_db();
    return await db.insert(tablesName[1], donation.toJSON());
  }

  static getDonationsById(int user) async {
    Database db = await dao.get_db();
    return await db.query(tablesName[1], where: "user = ?", whereArgs: [
      user
    ], columns: [
      "id",
      "titulo",
      "descricao",
      "enderecoRua",
      "enderecoBairro",
      "estado",
      "numero",
      "url_imagem"
    ]);
  }
  // updateDonation(doacao newDonation) async {
  //   Database db = await get_db();
  //   return await db.rawUpdate(
  //   'UPDATE $tablesName[1] SET name = ?, value = ? WHERE id = ? ',
  //   ['updated name', '9876', 'some name']);

  // }
}
