import 'package:brinquedoar_flutter/ui/pages/sobre.dart';
import 'package:brinquedoar_flutter/ui/pages/login.dart';
import 'package:brinquedoar_flutter/ui/pages/cadastro.dart';
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
        body: Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fundo.png'), fit: BoxFit.cover)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(),
              content(),
              TextButton(
                child: const Text('Saiba mais',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromRGBO(81, 181, 159, 1))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sobre()));
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                width: 288,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                    },
                      child: const Text('Login',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                      style: styleBtn,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => cadastro()));
                      },
                      child: const Text('Cadastrar',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                      style: styleBtn,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

logo() {
  return Container(
    padding: const EdgeInsets.only(bottom: 20),
    child: Center(
        child: Image.asset(
      'assets/images/logo-colorida.png',
      width: 200,
      height: 159,
    )),
  );
}

content() {
  const data = ''' 
  BrinqueDOAR é um projeto realizado por um grupo
  de jovens apaixonados pela tecnologia e ansiosos
  para mudar o mundo, mesmo que seja de pouquinho
  em poquinho.
  É um aplicativo que cada um pode ajudar o 
  próximo como pode e ainda uma comunidade de 
  esperança. Se interessou? 
  ''';
  return (Column(
    children: const [
      Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
      )
    ],
  ));
}

