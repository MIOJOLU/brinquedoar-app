// ignore_for_file: file_names
import 'dart:math' as math;
import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:brinquedoar_flutter/ui/pages/Feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  String url_imagem;

  mostrarDoacao(
      {Key? key,
      this.idDoacao,
      required this.titulo,
      required this.descricao,
      required this.enderecoRua,
      required this.enderecoBairro,
      required this.numero,
      required this.estado,
      required this.user,
      required this.url_imagem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => mostrarDoacaoState(doacao.withId(
      user: user,
      titulo: titulo,
      descricao: descricao,
      enderecoBairro: enderecoBairro,
      enderecoRua: enderecoRua,
      numero: numero,
      estado: estado,
      url_imagem: url_imagem,
    id: idDoacao!
  ));
}

class mostrarDoacaoState extends State<mostrarDoacao> {
  doacao currentDonation;
  int uid = -1;

  final dao brinquedoarRepository = dao();

  mostrarDoacaoState(this.currentDonation);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [mostrarDoacaoAtual()]),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }

  logo() {
    return Image.asset(
      'assets/images/logo-colorida.png',
      width: 100,
      height: 59,
    );
  }

  mostrarDoacaoAtual() {
    return Container(
        child: Center(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Feed()))
                        }),
                logo()
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Descrição da Doação",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            imageOrIcon(),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
              child: Text(
                currentDonation.titulo,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text("Rua " +
                currentDonation.enderecoRua +
                ", n° " +
                currentDonation.numero.toString() +
                " - Bairro " +
                currentDonation.enderecoBairro,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(currentDonation.estado,
                style: TextStyle(fontSize: 12, color: Colors.grey)
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(currentDonation.descricao,
                textAlign: TextAlign.justify,
              ),
            ),
            mostrarOpcoesBotao()
          ],
        )),
        padding: const EdgeInsets.only(top: 30));
  }

  void deleteDonation() async {
    await brinquedoarRepository.deleteDonation(currentDonation.id);
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      uid = prefs.getInt("id")!;
    });
  }

  mostrarOpcoesBotao(){
    if(uid == currentDonation.user){
      return IconButton(
        icon: Image.asset('assets/images/lixera.png'),
        iconSize: 50,
        onPressed: () {
          deleteDonation();
          Navigator.pop(context, MaterialPageRoute(builder: (context) => const Feed()));
        },
      );
    }

    return const Text("");
  }

  Widget imageOrIcon() {
    if (Uri.parse(currentDonation.url_imagem).isAbsolute){
      return Image(
        image: NetworkImage(currentDonation.url_imagem),
        width: 200,
        height: 200,
      );
    }
     return Container(
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            currentDonation.titulo.characters.first.toUpperCase(),
            style:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
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
