const String dbDoacao = "donations";
class TableDoacao {
  static String id = '_id';
  static String user = 'user';
  static String titulo = 'titulo';
  static String enderecoRua = 'enderecoRua';
  static String descricao = 'descricao';
  static String enderecoBairro = 'enderecoBairro';
  static String estado = 'estado';
  static String numero = 'numero';
  static String url_imagem = 'url_imagem';
}

class doacao{
  String titulo = "";
  String descricao = "";
  String enderecoRua = "";
  String enderecoBairro = "";
  int numero = -1;
  String estado = "";
  int user = -1;
  int id = -1;
  String url_imagem = "";

  doacao({
    required this.user,
    required this.titulo,
    required this.descricao,
    required this.enderecoRua,
    required this.enderecoBairro,
    required this.estado,
    required this.numero,
    required this.url_imagem
  });

  doacao.withId({
    required this.id,
    required this.user,
    required this.titulo,
    required this.descricao,
    required this.enderecoRua,
    required this.enderecoBairro,
    required this.estado,
    required this.numero,
    required this.url_imagem
  });

  //doacao(this.user, this.titulo, this.descricao, this.enderecoRua, this.enderecoBairro, this.estado, this.numero);

  doacao.fromQuery(var query){
    titulo = query["titulo"];
    descricao = query["descricao"];
    enderecoRua = query["enderecoRua"];
    enderecoBairro = query["enderecoBairro"];
    numero = int.parse(query["numero"]);
    estado = query["estado"];
    url_imagem = query["url_imagem"];
    user = int.parse(query["user"].toString());
    id = int.parse(query["_id"].toString());
  }

  Map<String, Object> toJSON() => {
    TableDoacao.user: user,
    TableDoacao.titulo: titulo,
    TableDoacao.descricao: descricao,
    TableDoacao.enderecoRua: enderecoRua,
    TableDoacao.enderecoBairro: enderecoBairro,
    TableDoacao.numero: numero,
    TableDoacao.estado: estado,
    TableDoacao.url_imagem: url_imagem
  };

  Map<String, Object> toJSONobj() => {
    "user": this.user,
    "titulo": this.titulo,
    "descricao": this.descricao,
    "enderecoRua": this.enderecoRua,
    "enderecoBairro:": this.enderecoBairro,
    "numero": this.numero,
    "estado": this.estado
  };

}