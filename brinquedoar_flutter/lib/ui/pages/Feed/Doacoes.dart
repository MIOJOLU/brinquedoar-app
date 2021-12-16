// ignore_for_file: file_names

import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mostrarDoacao extends StatefulWidget {
  int? idDoacao;
  String titulo = "";
  String descricao = "";
  String enderecoRua = "";
  String enderecoBairro = "";
  int numero = -1;
  String estado = "";
  int user = -1;

  mostrarDoacao({
    Key? key,
    this.idDoacao,
    required this.titulo,
    required this.descricao,
    required this.enderecoRua,
    required this.enderecoBairro,
    required this.numero,
    required this.estado,
    required this.user})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => mostrarDoacaoState(doacao(
      user: user,
      titulo: titulo,
      descricao: descricao,
      enderecoBairro: enderecoBairro,
      enderecoRua: enderecoRua,
      numero: numero,
      estado: estado));
}

class mostrarDoacaoState extends State<mostrarDoacao> {
  doacao currentDonation;

  mostrarDoacaoState(this.currentDonation);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [mostrarDoacaoAtual()]),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }

  mostrarDoacaoAtual() {
    return Container(
        child: Center(child: Column(
          children: [
            Text("Título: " + currentDonation.titulo),
            Text("Descricao: " + currentDonation.descricao),
            Text("Rua: " + currentDonation.enderecoRua),
            Text("Bairro: " + currentDonation.enderecoBairro),
            Text("Número: " + currentDonation.numero.toString()),
            Text("Estado: " + currentDonation.estado),
          ],
        )),
        padding: const EdgeInsets.only(top: 30)
    );
  }

// void updateDonationData() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   setState(() {
//     print(prefs.getStringList("d-" + idDoacao!.toString()));
//     titulo = prefs.getStringList("d-" + idDoacao!.toString())!.first;
//   });
// }
}

Widget sectionDoacao(bool isLoading) {
  late List<doacao> doacoes;
  bool isLoading = false;
  return Scaffold(
    body: Center(
      /*child: isLoading
          ? const CircularProgressIndicator()
          : doacao.
              ? Text(
                  'No Notes',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )
              : buildNotes(),*/
    ),
  );
}

Future refreshDoacoes() async {
  //isLoading = true;
  // final prefs = await SharedPreferences.getInstance();
  // int? user = prefs.getInt("id");
  // doacoes = await DoacaoService.getDonationsById(user!);
  //isLoading = false;
}