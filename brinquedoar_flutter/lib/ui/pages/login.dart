import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/ui/pages/home.dart';
import 'package:brinquedoar_flutter/ui/pages/cadastro.dart';
import 'package:brinquedoar_flutter/ui/pages/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget{
  @override
  _login createState() => _login();
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

class _login extends State<login> {
  final styleeBtn = ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(81, 181, 159, 1),
      shadowColor: const Color(0x00000000),
      fixedSize: const Size(320, 42),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final dao brinquedoarRepository = dao();

  void logarUsuario(String email, String password) async {
    var user = await brinquedoarRepository.getUserByEmail(email);

    if(user["senha"] == password){
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("nome", user["nome"]);
      await prefs.setString("email", user["email"]);
      await prefs.setInt("id", user["id"]);
      await prefs.setInt("isONG", user["isONG"]);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Feed()));
    }
    else{
      print("fail");
    }
  }

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
              padding: const EdgeInsets.all(16),
              child: Column(
                children:  [
                  //const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
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
                  TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      logarUsuario(_emailController.text, _passwordController.text);
                    },
                    child: const Text('Login',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    style: styleeBtn,

                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => cadastro()));
                    },
                    child: const Text(
                        "Ainda não possui um cadastro? Cadastrar!",
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

