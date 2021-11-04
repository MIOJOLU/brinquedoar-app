import 'dart:ui';

import 'package:flutter/material.dart';
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

class FeedState extends State<Feed> {
  var currentSection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        feedHeader(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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

  Color getSectionColor(int currentSection, sectionID){
    if(currentSection == sectionID) {
      return const Color.fromRGBO(239, 50, 32, 1);
    }

    return Colors.black;
  }
}




