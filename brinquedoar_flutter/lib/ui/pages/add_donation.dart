// ignore_for_file: camel_case_types

import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/ui/pages/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:brinquedoar_flutter/model/docao.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class AdicionarDoacao extends StatefulWidget {
  @override
  _donationState createState() => _donationState();
}

class _donationState extends State<AdicionarDoacao> {
  final styleeBtn = ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(81, 181, 159, 1),
      shadowColor: const Color(0x00000000),
      fixedSize: const Size(320, 42),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _enderecoRuaController = TextEditingController();
  final TextEditingController _enderecoBairroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        home: Scaffold(
            body: SafeArea(
                child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => {},
                      ),
                      logo()
                    ],
                  ),
                  Text('Adicionar uma nova doação'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: TextFormField(
                      controller: _tituloController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: " Título",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(81, 181, 159, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _descricaoController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: " Descrição",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(81, 181, 159, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _enderecoRuaController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: " Rua",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(81, 181, 159, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _enderecoBairroController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: " Bairro",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(81, 181, 159, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _estadoController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: " Estado",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(81, 181, 159, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _numeroController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: " Número",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(81, 181, 159, 1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      )),
                      ElevatedButton(
                              onPressed: () {
                                _adicionarDoacao(_tituloController.text, _descricaoController.text, _enderecoRuaController.text, _enderecoBairroController.text, _estadoController.text,  int.parse(_numeroController.text));
                                Navigator.pop(context, MaterialPageRoute(builder: (context) => Feed()));
                              },
                              child: const Text('Cadastrar',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              style: styleeBtn,

                            )
                ],
              ),
            )
          ],
        ))));
  }

  static _adicionarDoacao(String titulo, String descricao, String rua, String bairro, String estado,  int numero) async {
    final prefs = await SharedPreferences.getInstance();
    int? user =  prefs.getInt("id");
    doacao donation =  doacao(user: user!, titulo: titulo, descricao: descricao, enderecoRua: rua, enderecoBairro: bairro, estado: estado, numero: numero);
    int id = await dao.insertDonations(donation);
    print(id);
  }

  logo() {
    return Image.asset(
      'assets/images/logo-colorida.png',
      width: 100,
      height: 59,
    );
  }

  Widget form() {
    return Column(
      children: [
        TextFormField(
          controller: _tituloController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              labelText: 'Título',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(81, 181, 159, 1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        )
      ],
    );
  }
}
