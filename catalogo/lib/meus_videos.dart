import 'package:catalogo/create_video.dart';
import 'package:catalogo/database.dart';
import 'package:catalogo/edit_video.dart';
import 'package:catalogo/model_user.dart';
import 'package:catalogo/model_video.dart';
import 'package:catalogo/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyVideos extends StatefulWidget {
  final User user;
  const MyVideos(this.user, {super.key});

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  List<Video> _myVideos = [];

  @override
  void initState() {
    super.initState();
    _carregarVideos();
  }

  Future<void> _carregarVideos() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> usuariosVideos = await db!.rawQuery('''
      SELECT * 
      FROM video 
      WHERE id IN (
        SELECT videoid 
        FROM user_video 
        WHERE userid = ?
      )
      
    ''', [widget.user.id]);

    List<Video> videos = usuariosVideos
        .map((item) => Video(
              id: item['id'],
              name: item['name'],
              description: item['description'],
              type: item['type'],
              ageRestriction: item['ageRestriction'],
              durationMinutes: item['durationMinutes'],
              thumbnailImageId: item['thumbnailImageId'],
              releaseDate: item['releaseDate'],
            ))
        .toList();

    setState(() {
      _myVideos = videos;
    });
  }

  List<Video> getMyVideos() {
    //loadVideos();
    _carregarVideos();
    return _myVideos;
  }

  Widget barraSuperior() {
    return Container(
      color: const Color(0xFF57585a),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateVid(widget.user.id)));
              },
              child: const Row(
                children: [
                  Icon(Icons.add_circle_outline_sharp),
                  Text("Criar Video"),
                ],
              )),
          const Padding(padding: EdgeInsets.all(10.0)),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const Row(children: [
              Icon(Icons.logout),
              Text("Deslogar"),
            ]),
          ),
        ],
      ),
    );
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
          child: Stack(
            children: <Widget>[
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
                      ],
                    ),
                  ),
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 2.0),
                          bottom: BorderSide(width: 1.0),
                        ),
                        color: Colors.white,
                      ),
                      child: barraSuperior(),
                    ),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Builder(builder: (context) {
                      final List<Video> myVideos = getMyVideos();
                      return ListView(
                          shrinkWrap: true,
                          children: myVideos
                              .map((item) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: ListTile(
                                    title: Text(item.name),
                                    subtitle: Text(item.description),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(item.thumbnailImageId),
                                    ),
                                    trailing: SizedBox(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditVideo(item)));
                                                },
                                                icon: const Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  DatabaseHelper()
                                                      .deleteUserVideo(item.id,
                                                          widget.user.id);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Video removido com sucesso!')));
                                                  setState(() {
                                                    _carregarVideos();
                                                  });
                                                },
                                                icon: const Icon(Icons.delete))
                                          ],
                                        )),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MoviePage(item)));
                                    },
                                  )))
                              .toList());
                    })
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
