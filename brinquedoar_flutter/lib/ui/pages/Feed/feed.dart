import 'dart:ui';

import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:brinquedoar_flutter/service/doacao.service.dart';
import 'package:brinquedoar_flutter/ui/pages/Feed/Doacoes.dart';
import 'package:brinquedoar_flutter/ui/pages/add_donation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
// class runFeed extends StatelessWidget {
//   const runFeed({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(fontFamily: 'Inter'),
//         home: Feed()
//     );
//   }
// }

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedState();
}

late List<doacao> doacoes;
bool isLoading = false;

Future refreshDoacoes() async {
  isLoading = true;
  final prefs = await SharedPreferences.getInstance();
  int? user = prefs.getInt("id");
  doacoes = await DoacaoService.getDonationsById(user!);
  isLoading = false;
}

class FeedState extends State<Feed> {
  var currentSection = 0;
  String? nome = "";
  String? email = "";
  String? bio = "";
  int? id = -1;
  bool? isONG = false;

  final dao brinquedoarRepository = dao();
  final DoacaoService ds = DoacaoService();
  late Future donationRequest;

  FeedState() {
    donationRequest = getDonations();
  }

  getDonations() async {
    await getUserData();

    List returnList = await brinquedoarRepository.getDonationsById(id!);

    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: corpoPagina(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }

  Widget corpoPagina() {
    return Column(children: [
      feedHeader(),
      conteudo(currentSection),
    ]);
  }

  Widget feedHeader() {
    return Container(
      child: Center(
          child: Column(children: [
        Image.asset(
          'assets/images/logo-colorida.png',
          width: 160,
          height: 119,
        ),
        Padding(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  GestureDetector(
                      child: Text(
                        "doações",
                        style: TextStyle(
                            color: getSectionColor(currentSection, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () => {
                            setState(() {
                              currentSection = 0;
                            })
                          }),
                  const SizedBox(width: 15),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 20,
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    child: Text("pedidos",
                        style: TextStyle(
                            color: getSectionColor(currentSection, 1),
                            fontWeight: FontWeight.bold)),
                    onTap: () => {
                      setState(() {
                        currentSection = 1;
                      })
                    },
                  ),
                  const SizedBox(width: 15),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 20,
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                      child: Text("perfil",
                          style: TextStyle(
                              color: getSectionColor(currentSection, 2),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {
                            setState(() {
                              currentSection = 2;
                            })
                          }),
                ],
              ),
            ),
            padding: const EdgeInsets.only(left: 50, right: 50)),
        Padding(
            child: IntrinsicHeight(
              child: Row(
                children: const [],
              ),
            ),
            padding: const EdgeInsets.only(left: 50, right: 50))
      ])),
      padding: const EdgeInsets.only(top: 30),
    );
  }

  Widget conteudo(int currentSection) {
    if (currentSection == 0) {
      return sectionDoacao(isLoading);
    }
    if (currentSection == 1) {
      return feedPedidos();
    } else {
      return perfil();
    }
  }

  Widget pedido() {
    return Container();
  }

  Widget perfil() {
    return Column(children: [
      fotoPerfil(),
      infoUsuario(),
      abaDoacoes(),
    ]);
  }

  fotoPerfil() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Center(
          child: Image.asset(
        'assets/images/fotoPerfil.png',
        width: 135,
      )),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  infoUsuario() {
    getUserData();

    return Column(children: [Text(nome!), Text(bio!)]);
  }

  abaDoacoes() {
    return Column(children: [
      Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 50, top: 4, bottom: 0),
          child: Row(children: [
            const Text("Minhas Doações",
                style: TextStyle(fontWeight: FontWeight.bold)),
            adicionarDoacaoBotao()
          ])),
      Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 50, top: 0, bottom: 10),
          child: Container(
            height: 70,
            child: ListView(
                scrollDirection: Axis.horizontal, children: [showDoacoes()]),
          ))
    ]);
  }

  adicionarDoacaoBotao() {
    return TextButton(
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: const Text('+',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(81, 181, 159, 1))),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdicionarDoacao())).then((value) {
              setState(() {
                donationRequest = getDonations();
              });
            });
      },
    );
  }

  FutureBuilder showDoacoes() {
    return FutureBuilder(
        future: donationRequest,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            List<Widget> widgets = [];

            List doacoes =
                snapshot.data.map((c) => doacao.fromQuery(c)).toList();

            for (var entry in doacoes) {
              widgets.add(doacaoBox(entry));
              widgets.add(const SizedBox(width: 15));
            }

            return Row(children: widgets);
          } else if (snapshot.hasError) {
            print("ERROR");
          } else {
            return const CircularProgressIndicator();
          }
          return const Text("");
        });
  }

  Widget doacaoBox(doacao data) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => mostrarDoacao(
                      user: data.user,
                      titulo: data.titulo,
                      descricao: data.descricao,
                      enderecoBairro: data.enderecoBairro,
                      enderecoRua: data.enderecoRua,
                      numero: data.numero,
                      estado: data.estado)));
        },
        child: Container(
          width: 70,
          height: 70,
          child: Center(
              child: Text(data.titulo.characters.first.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
          color: Colors.grey,
        ));
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nome = prefs.getString("nome");
      bio = prefs.getString("bio");
      email = prefs.getString("email");
      id = prefs.getInt("id");
      isONG = prefs.getBool("isONG") == 1 ? true : false;
    });
  }

  Color getSectionColor(int currentSection, sectionID) {
    if (currentSection == sectionID) {
      return const Color.fromRGBO(239, 50, 32, 1);
    }

    return Colors.black;
  }

  void renderPedidos() async {
    final prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("id");

    // Remover estatico
    List query = brinquedoarRepository.getPedidosById(31);

    //return query;
  }

  Widget feedPedidos() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.smart_toy),
            title: const Text('Pedido 1'),
            subtitle: Text(
              'Pedido a caminho',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 1'),
              ),
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
