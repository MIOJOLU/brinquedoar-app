import 'package:brinquedoar_flutter/ui/pages/home.dart';
import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        home: AboutContent()));
  }
}

class AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
          shadowColor: const Color.fromRGBO(255, 255, 255, 1),
          toolbarHeight: 35,
          leading: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(81, 181, 159, 1),
            ),
          )),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fundo.png'),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [logo()],
            ),
            content()
          ],
        ),
      ),
    ));
  }
}

logo() {
  return Container(
    padding: const EdgeInsets.only(bottom: 25),
    child: Center(
        child: Image.asset(
      'assets/images/logo-colorida.png',
      width: 150,
      height: 109,
    )),
  );
}

img() {
  return (Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Image.asset(
        'assets/images/larm-rmah-AEaTUnvneik-unsplash.png',
        width: 243.47,
        height: 149,
      )));
}

content() {
  const data = ''' 
  BrinqueDOAR é um prpjeto realizado por um grupo
  de jovens apaixonados pela tecnologia e ansiosos
  para mudar o mundo, mesmo que seja de pouquinho
  em poquinho. É um aplicativo que cada um pode 
  ajudar o próximo como pode e ainda uma comunidade
  de esperança. Se interessou? 
  ''';
  return (Column(
    children: [
      img(),
      Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: const Text(
          'SOBRE NÓS',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      )
    ],
  ));
}
