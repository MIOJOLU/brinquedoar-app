class Pedido {
  int? id;
  int? id_user;
  String? status;
  String? descricao;

  Pedido(this.id_user, this.status, this.descricao);

  Pedido.fromQuery(var query){
    id_user = query["id_user"];
    status = query["status"];
    descricao = query["descricao"];
    id = query["id"];
  }

  toJson(){
    Map<String, dynamic> userData = {
      "id_user": id_user,
      "status": status,
      "descricao": descricao,
    };

    return userData;
  }
}
