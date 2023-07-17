import 'package:catalogo/signin.dart';
import 'package:catalogo/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Database db;

  final TextEditingController _emailController =
      TextEditingController(); //serve para pegar o input do usuário no campo email
  final TextEditingController _passwordController =
      TextEditingController(); //serve para pegar o input do usuário no campo senha

  _save() async {
    db = await DatabaseManager
        .instance.database; // pega o db criado em database.dart
    await db.insert('user', {
      'name': 'luciano',
      'email': 'luciano@gmail.com',
      'password': '123456',
    });

    await db.insert('user', {
      'name': 'Teste 2',
      'email': 'teste2@teste',
      'password': '123456',
    });

    await db.insert('user', {
      'name': 'Teste 3',
      'email': 'teste3@teste',
      'password': '123456',
    });

    await db.insert('user', {
      'name': 'Teste 4',
      'email': 'teste4@teste',
      'password': '123456',
    });

    await db.insert('user', {
      'name': 'Teste 5',
      'email': 'teste5@teste',
      'password': '123456',
    });

    await db.insert('genre', {
      'name': 'Comedia',
    });

    await db.insert('genre', {
      'name': 'Terror',
    });

    await db.insert('genre', {
      'name': 'Aventura',
    });

    await db.insert('genre', {
      'name': 'Suspense',
    });

    await db.insert('genre', {
      'name': 'Ação',
    });

    await db.insert('video', {
      'name': 'Filme 1',
      'description': 'Descrição 1',
      'type': 0,
      'ageRestriction': '18 anos',
      'durationMinutes': 120,
      'thumbnailImageId': 'url imagem',
      'releaseDate': '01/01/2020',
    });

    await db.insert('video', {
      'name': 'Filme 2',
      'description': 'Descrição 2',
      'type': 0,
      'ageRestriction': '18 anos',
      'durationMinutes': 120,
      'thumbnailImageId': 'url imagem',
      'releaseDate': '01/01/2020',
    });

    await db.insert('video', {
      'name': 'Filme 3',
      'description': 'Descrição 3',
      'type': 0,
      'ageRestriction': '18 anos',
      'durationMinutes': 120,
      'thumbnailImageId': 'url imagem',
      'releaseDate': '01/01/2020',
    });

    await db.insert('video', {
      'name': 'Filme 4',
      'description': 'Descrição 4',
      'type': 0,
      'ageRestriction': '18 anos',
      'durationMinutes': 120,
      'thumbnailImageId': 'url imagem',
      'releaseDate': '01/01/2020',
    });

    await db.insert('video', {
      'name': 'Filme 5',
      'description': 'Descrição 5',
      'type': 0,
      'ageRestriction': '18 anos',
      'durationMinutes': 120,
      'thumbnailImageId': 'url imagem',
      'releaseDate': '01/01/2020',
    });

    await db.insert('video_genre', {
      'videoid': 1,
      'genreid': 1,
    });

    await db.insert('video_genre', {
      'videoid': 1,
      'genreid': 2,
    });

    await db.insert('video_genre', {
      'videoid': 2,
      'genreid': 5,
    });

    await db.insert('video_genre', {
      'videoid': 3,
      'genreid': 4,
    });

    await db.insert('video_genre', {
      'videoid': 4,
      'genreid': 3,
    });

    await db.insert('video_genre', {
      'videoid': 5,
      'genreid': 1,
    });

    await db.insert('video_genre', {
      'videoid': 5,
      'genreid': 5,
    });
  }
  // usei o list para ver se um novo usuário foi cadastrado corretamente

  // _list() async {
  //   db = await DatabaseManager.instance.database;

  //   String sql = "SELECT * FROM user;";
  //String sql = "SELECT * FROM usuarios WHERE idade < 20";
  //String sql = "SELECT * FROM usuarios WHERE idade > 20 AND idade < 25";
  //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 20 AND 25";
  ///String sql = "SELECT * FROM usuarios WHERE nome LIKE 'ana%'";
  //String sql = "SELECT * FROM usuarios ORDER BY nome DESC";

  //  List usuarios = await db.rawQuery(sql);
  //  print("usuarios: ${usuarios.toString()}");
  //}
  _validateLogin(String email, String password) async {
    db = await DatabaseManager.instance.database;

    List<Map<String, dynamic>> results = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      print(
          "FUNCIONOU"); // to do redirecionar para a pagina do catalogo de videos
    } else {
      print(
          "email ou senha incorretos"); // to do pedir para o usuario tentar novamente
    }
  }

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

  Widget buildSignin() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: TextButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Signin())),
          child: const Text(
            'Não tem conta? Cadastre aqui!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildLogin() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            String email = _emailController.text;
            String password = _passwordController.text;
            _validateLogin(email, password);
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: const Text('Login'),
        ));
  }

  Widget buildLoginless() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // ir para a pagina do catalogo, sem login
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: const Text('Seguir sem logar'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //_save();
    //_list();

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
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 25),
                          buildEmail(),
                          const SizedBox(height: 20),
                          buildPassword(),
                          buildSignin(),
                          buildLogin(),
                          buildLoginless(),
                        ],
                      ),
                    ))
              ]),
            )));
  }
}
