import 'package:brinquedoar_flutter/ui/pages/sobre.dart';
import 'package:brinquedoar_flutter/ui/pages/login.dart';
import 'package:brinquedoar_flutter/ui/pages/cadastro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        home: HomeNavigation());
  }
}

class HomeNavigation extends StatelessWidget {
  final styleBtn = ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(81, 181, 159, 1),
      shadowColor: const Color(0x00000000),
      fixedSize: const Size(131, 42),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: new ExactAssetImage('assets/images/fundo.png')
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Image.asset('assets/images/logo-colorida.png', width: 180, height: 139),

              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: content(),
              )
            ],
          ),
            Padding(padding: EdgeInsets.only(bottom: 20), child:
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Sobre()));
                        },
                        child: const Text("Saiba mais", textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color.fromRGBO(81, 181, 159, 1),)
                        )
                    ))
              ],
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 10), child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(81, 181, 159, 1)),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left: 35, right: 35)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(81, 181, 159, 1)))
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 12),),
                    ),),
                  ]),
                  Column(
                    children: [

                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => cadastro()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(81, 181, 159, 1)),
                          padding: MaterialStateProperty.all(const EdgeInsets.only(left: 35, right: 35)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(const BorderSide(color: Color.fromRGBO(81, 181, 159, 1)))
                        ),
                        child: const Text('Cadastro', style: TextStyle(fontSize: 12),),
                      )
                    ],
                  )
              ],
            )
        ],)
      ),

    );
  }
}

content() {
  const data = "BrinqueDOAR é um projeto realizado por um grupo "
      "de jovens apaixonados pela tecnologia e ansiosos"
      "para mudar o mundo, mesmo que seja de pouquinho em poquinho. "
      "É um aplicativo que cada um pode ajudar o próximo como pode e ainda uma comunidade de"
      "esperança. Se interessou? "
  ;
  return const Padding(padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 4),
  child: Text(
    data,
    textAlign: TextAlign.justify,
    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
  ));
}

