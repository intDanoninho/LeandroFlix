
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:catalogo/database.dart';
class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _HomeState();
}

class _HomeState extends State<Signin> {
  late Database db;


  _validateSignin(String name, String email, String password) async {
    db = await DatabaseManager.instance.database;

    Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "password": password,
    };

    await db.insert("user", userData);

    //to do verificar se o email já está sendo usado e notificar  
    //to do notificar que foi cadastrado corretamente

  }
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
   
  Widget buildEmail() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset (0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xffeb627c)
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          ),
          )
        )
      ],
    );

  }
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset (0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          controller: _passwordController,
          obscureText: true,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xffeb627c)
            ),
            hintText: 'Senha',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          ),
          )
        )
      ],
    );

  }
  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset (0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          controller: _nameController,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.account_box,
              color: Color(0xffeb627c)
            ),
            hintText: 'Nome',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          ),
          )
        )
      ],
    );

  }
  Widget buildSignin(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String name = _nameController.text;
          String email = _emailController.text;
          String password = _passwordController.text;
          _validateSignin(name, email, password);

        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.red, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        child: Text('Cadastre'),
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    
    

    return Scaffold(
      appBar: AppBar(title:  Text("LeandroFlix"), backgroundColor: Colors.red,),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0x6657585a),
                      Color(0x9957585a),
                      Color(0xcc57585a),
                      Color(0xff57585a),
                    ]
                  )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                       'Cadastro',
                       style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                       ),
                    ),
                    SizedBox(height: 20),
                    buildName(),
                    SizedBox(height: 20),
                    buildEmail(),
                    SizedBox(height: 20),
                    buildPassword(),
                    buildSignin(),
                  ],

                ),
                )
              )
            ]
          )
          ,))
    );
  }
}