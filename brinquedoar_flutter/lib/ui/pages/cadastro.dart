import 'package:brinquedoar_flutter/data/dao.dart';
import 'package:brinquedoar_flutter/model/user.dart';
import 'package:brinquedoar_flutter/ui/pages/home.dart';
import 'package:brinquedoar_flutter/ui/pages/login.dart';
import 'package:brinquedoar_flutter/ui/pages/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();

  final dao brinquedoarRepository = dao();

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

  _cadastrarUsuario(String nome, String email, String password, String confirmPassword, bool isONG) async {
    if(password == confirmPassword){
      User newUser = User(nome, email, password, isONG, "");

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("nome", nome);
      await prefs.setString("email", email);
      await prefs.setInt("id", await brinquedoarRepository.insertUser(newUser.toJson()));
      await prefs.setInt("isONG", isONG == true? 1 : 0);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Feed()));
    }
    else {
      _limparDados();
    }
  }

  _limparDados(){
    _passwordController.text = "";
    _passConfirmController.text = "";
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
                              controller: _nameController,
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
                            const SizedBox(height: 15),
                            TextField(
                              controller: _passConfirmController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
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
                                _cadastrarUsuario(_nameController.text, _emailController.text, _passwordController.text, _passConfirmController.text, isChecked);
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

