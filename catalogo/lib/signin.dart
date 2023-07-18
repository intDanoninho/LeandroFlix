import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:catalogo/database.dart';
import 'package:quickalert/quickalert.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _HomeState();
}

class _HomeState extends State<Signin> {
  late Database db;

  _validateSignin(String name, String email, String password) async {
    Database? db = await DatabaseHelper().db;

    List<Map<String, dynamic>> results = await db!.query(
      // confere se o email inserido já foi cadastrado
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (email.isNotEmpty &&
        name.isNotEmpty &&
        password.isNotEmpty &&
        results.isEmpty) {
      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "password": password,
      };

      await db.insert("user", userData);
      // ignore: use_build_context_synchronously
      QuickAlert.show(
          context: context,
          text: "Cadastro feito com sucesso!",
          confirmBtnText: "voltar",
          type: QuickAlertType.success,
          onConfirmBtnTap: () =>
              Navigator.popUntil(context, (route) => route.isFirst));
    } else {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        text: "Email já em uso ou inválido",
        confirmBtnText: "Entendi",
        type: QuickAlertType.error,
      );
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email, color: Color(0xffeb627c)),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ))
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Senha',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock, color: Color(0xffeb627c)),
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.black38)),
            ))
      ],
    );
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Nome',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.account_box, color: Color(0xffeb627c)),
                  hintText: 'Nome',
                  hintStyle: TextStyle(color: Colors.black38)),
            ))
      ],
    );
  }

  Widget buildSignin() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            String name = _nameController.text;
            String email = _emailController.text;
            String password = _passwordController.text;
            _validateSignin(name, email, password);
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: const Text('Cadastre'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("LeandroFlix"),
          backgroundColor: Colors.red,
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              child: Stack(children: <Widget>[
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Color(0x6657585a),
                          Color(0x9957585a),
                          Color(0xcc57585a),
                          Color(0xff57585a),
                        ])),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Cadastro',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          buildName(),
                          const SizedBox(height: 20),
                          buildEmail(),
                          const SizedBox(height: 20),
                          buildPassword(),
                          buildSignin(),
                        ],
                      ),
                    ))
              ]),
            )));
  }
}
