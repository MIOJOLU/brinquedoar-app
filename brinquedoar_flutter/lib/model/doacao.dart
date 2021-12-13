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
}

class doacao{
  final String titulo;
  final String descricao;
  final String enderecoRua;
  final String enderecoBairro;
  final int numero;
  final String estado;
  final int user;

  const doacao({
    required this.user,
    required this.titulo,
    required this.descricao,
    required this.enderecoRua,
    required this.enderecoBairro,
    required this.estado,
    required this.numero
  });

  Map<String, Object> toJSON() => {
      TableDoacao.user: user,
      TableDoacao.titulo: titulo,
      TableDoacao.descricao: descricao,
      TableDoacao.enderecoRua: enderecoRua,
      TableDoacao.enderecoBairro: enderecoBairro,
      TableDoacao.numero: numero,
      TableDoacao.estado: estado
  };

}