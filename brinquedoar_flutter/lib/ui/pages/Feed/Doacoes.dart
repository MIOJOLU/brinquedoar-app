// ignore_for_file: file_names

import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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