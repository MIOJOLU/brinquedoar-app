import 'dart:ui';

import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/model/docao.dart';
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
  State<StatefulWidget> createState () => FeedState();
}
late List<doacao> doacoes;
bool isLoading = false;

Future refreshDoacoes() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    int? user =  prefs.getInt("id");
    doacoes =  await dao.getAllDonations(user!);
    isLoading = false;
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
  final dao Dao = dao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        corpoPagina(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }

  Widget corpoPagina(){

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

  Widget conteudo(int currentSection){
    if(currentSection == 0) // Luiza
      return doacao();
    if(currentSection == 1) // Diogo
      return pedido();
    else {
      return perfil();
    }

  }

  Widget doacao(){
    return Scaffold(
      body: Center(
          // child: isLoading
          //     ? CircularProgressIndicator()
          //     : doacao.
          //         ? Text(
          //             'No Notes',
          //             style: TextStyle(color: Colors.white, fontSize: 24),
          //           )
          //         : buildNotes(),
        ),  
    );
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
          TextButton(
                child: const Text('Inserir doação',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(81, 181, 159, 1))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdicionarDoacao()));
                },
              )
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
}




