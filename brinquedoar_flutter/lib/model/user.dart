class User {
  String? nome;
  String? email;
  String? senha;
  int? id;
  bool? isONG;

  User(this.nome, this.email, this.senha, this.isONG);

  User.fromQuery(var query){
    nome = query["nome"];
    email = query["email"];
    senha = query["senha"];
    isONG = query["isONG"] == 1? true : false;
    id = query["id"];
  }

  toJson(){
    Map<String, dynamic> userData = {
    "nome": nome,
    "email": email,
    "senha": senha,
    "isONG": isONG == true? 1 : 0
    };

    return userData;
  }
}
