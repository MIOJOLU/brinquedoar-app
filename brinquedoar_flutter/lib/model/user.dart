class User {
  String? nome;
  String? email;
  String? bio;
  String? senha;
  int? id;
  bool? isONG;

  User(this.nome, this.email, this.senha, this.isONG, this.bio);

  User.fromQuery(var query){
    nome = query["nome"];
    email = query["email"];
    bio = query["bio"];
    senha = query["senha"];
    isONG = query["isONG"] == 1? true : false;
    id = query["id"];
  }

  toJson(){
    Map<String, dynamic> userData = {
    "nome": nome,
    "email": email,
    "senha": senha,
    "bio": bio,
    "isONG": isONG == true? 1 : 0
    };

    return userData;
  }
}
