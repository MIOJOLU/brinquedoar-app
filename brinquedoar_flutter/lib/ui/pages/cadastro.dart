import 'package:brinquedoar_flutter/ui/pages/home.dart';
import 'package:brinquedoar_flutter/ui/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cadastro extends StatefulWidget{
  @override
  _cadastro createState() => _cadastro();
}

logo() {
  return Container(
    padding: const EdgeInsets.only(bottom: 20),
    child: Center(
        child: Image.asset(
          'assets/images/logo-colorida.png',
          width: 180,
          height: 139,
        )),
  );
}

class _cadastro extends State<cadastro> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color.fromRGBO(81, 181, 159, 1);
    }
    return const Color.fromRGBO(81, 181, 159, 1);
  }
  final styleeBtn = ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(81, 181, 159, 1),
      shadowColor: const Color(0x00000000),
      fixedSize: const Size(320, 42),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        theme: ThemeData(fontFamily: 'Inter'),
        home: Scaffold(
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
                shadowColor: const Color.fromRGBO(255, 255, 255, 1),
                toolbarHeight: 50,
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
            body: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo(),
                  Container (
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Checkbox(

                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text("Sou uma ONG"),
                      ],
                    )
                  ),
                  Container (
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          children:  [
                            //const SizedBox(height: 30),


                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: "  Nome completo",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(81, 181, 159, 1),),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "  E-mail",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(81, 181, 159, 1),),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "  Senha",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(81, 181, 159, 1),),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 15),
                            const TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "  Confirmar senha",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(81, 181, 159, 1),),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                // Respond to button press
                              },
                              child: const Text('Cadastrar',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              style: styleeBtn,

                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => login()));
                              },
                              child: const Text(
                                  "Já tem cadastro? Logar!",
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),

                            )

                          ]
                      )
                  ),
                ]
            )
        )
    );
  }
}

