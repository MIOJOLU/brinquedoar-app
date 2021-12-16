// ignore_for_file: file_names

import 'package:brinquedoar_flutter/model/doacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget sectionDoacao(bool isLoading) {
  late List<doacao> doacoes;
  bool isLoading = false;
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ), //BoxDecoration
            ), //Container
          ), //Flexible
          SizedBox(
            width: 20,
          ), //SizedBox
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ) //BoxDecoration
            ), //Container
          ) //Flexible
        ], //<Widget>[]
        mainAxisAlignment: MainAxisAlignment.center,
      ), //Row
      Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: Container(
          width: 380,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue), //BoxDecoration
        ), //Container
      ), //Flexible
      Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              width: 180,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyan,
              ), //BoxDecoration
            ), //Container
          ), //Flexible
          SizedBox(
            width: 20,
          ), //SixedBox
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                  width: 180,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.cyan,
                  ) //BoxDecoration
              ) //Container,
          ) //Flexible
        ], //<widget>[]
        mainAxisAlignment: MainAxisAlignment.center,
      ), //Row
    ], //<Widget>[]
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
  );
}

Future refreshDoacoes() async {
  //isLoading = true;
  // final prefs = await SharedPreferences.getInstance();
  // int? user = prefs.getInt("id");
  // doacoes = await DoacaoService.getDonationsById(user!);
  //isLoading = false;
}
