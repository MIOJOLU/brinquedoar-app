import 'dart:ui';

import 'package:brinquedoar_flutter/data/dao.dart';
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
  State<StatefulWidget> createState () => FeedState();
}

fotoPerfil() {
  return Container(
    padding: const EdgeInsets.only(bottom: 20, top: 35),
    child: Center(
        child: Image.asset(
          'assets/images/perfil.png',
          width: 110,

        )),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  );
}

class FeedState extends State<Feed> {
  var currentSection = 0;

  final dao brinquedoarRepository = dao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        corpoPagina(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }

  Widget corpoPagina() {

    return Column(
      children: [
        feedHeader(),
        conteudo(currentSection),
      ]
      );
  }

  Widget feedHeader() {
    return Container(
      child: Center(
          child: Column(
              children: [
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
                              child: Text("doações",
                                style: TextStyle(color: getSectionColor(currentSection, 0), fontWeight: FontWeight.bold),
                              ),
                              onTap: () => {
                                setState(() {
                                  currentSection = 0;
                                })
                              }
                          ),
                          const SizedBox(width: 15),
                          const VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                            width: 20,
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            child: Text("pedidos",
                                style: TextStyle(color: getSectionColor(currentSection, 1), fontWeight: FontWeight.bold)),
                            onTap: () => {
                              setState( () {
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
                                  style: TextStyle(color: getSectionColor(currentSection, 2), fontWeight: FontWeight.bold)),
                              onTap: () => {
                                setState(() {
                                  currentSection = 2;
                                })
                              }
                          ),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 50, right: 50)
                ),
                Padding(
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 50, right: 50)
                )
              ]
          )
      ),
      padding: const EdgeInsets.only(top: 30),
    );
  }

  Widget conteudo(int currentSection) {
    if(currentSection == 0) // Luiza
      return doacao();
    if(currentSection == 1) // Diogo
      return feedPedidos();
    else
      return perfil();

  }

  Widget doacao(){
    return Container();
  }

  Widget pedido(){
    return Container();
  }

  Widget perfil(){
    return Container(
      child:
      Column(
        children:[
          fotoPerfil(),
        ]
      )
    );
  }



  Color getSectionColor(int currentSection, sectionID){
    if(currentSection == sectionID) {
      return const Color.fromRGBO(239, 50, 32, 1);
    }

    return Colors.black;
  }

  Future<List> renderPedidos() async {
    final prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("id");

    // Remover estatico
    List query = brinquedoarRepository.getPedidosById(31);

    return query;
  }


  Widget feedPedidos() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.smart_toy),
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




