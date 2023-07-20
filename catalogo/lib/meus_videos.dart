import 'package:catalogo/create_video.dart';
import 'package:catalogo/database.dart';
import 'package:catalogo/model_user.dart';
import 'package:catalogo/model_uservideo.dart';
import 'package:catalogo/model_video.dart';
import 'package:catalogo/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class MyVideos extends StatefulWidget {
  final User user;
  const MyVideos(this.user, {super.key});

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  List<Video> _myVideos = [];

  loadVideos() async {
    Database? db = await DatabaseHelper().db;

    final List<Map<String, dynamic>> userVideosData =
        await db!.rawQuery('SELECT * FROM user_video');
    final List<UserVideo> loadedUserVideos = userVideosData
        .map((item) => UserVideo(
              id: item['id'],
              userId: item['userid'],
              videoId: item['videoid'],
            ))
        .toList();

    List<Video> loadedVideos = [];

    for (UserVideo vUser in loadedUserVideos) {
      if (vUser.userId == widget.user.id) {
        final List<Map<String, dynamic>> videoData = await db
            .query('video', where: 'id = ?', whereArgs: [vUser.videoId]);
        loadedVideos.add(videoData
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
            .toList()[0]);
      }
    }
    if (mounted) {
      setState(() {
        _myVideos = loadedVideos;
      });
    }
  }

  List<Video> getMyVideos() {
    loadVideos();
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
                    ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final List<Video> videos = getMyVideos();
                          final item = videos[index];
                          if (videos.isEmpty) {
                            return const Center(
                              child: Text("Nenhum video encontrado"),
                            );
                          }
                          return Builder(builder: (context) {
                            return Dismissible(
                              key: Key(item.name),
                              onDismissed: (direction) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${item.name} removido com sucesso!")));
                                SnackBar(
                                  content: Text(
                                      "${item.name} removido com sucesso!"),
                                );
                                DatabaseHelper()
                                    .deleteUserVideo(item.id, widget.user.id);

                                if (mounted) {
                                  setState(() {
                                    videos.removeAt(index);
                                    if (videos.isEmpty) {}
                                  });
                                }
                              },
                              secondaryBackground: Container(
                                color: Colors.green,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 16,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              background: Container(
                                color: Colors.red,
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: ListTile(
                                  title: Text(item.name),
                                  subtitle: Text(item.description),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(item.thumbnailImageId),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MoviePage(item)));
                                  },
                                ),
                              ),
                            );
                          });
                        },
                        itemCount: getMyVideos().length),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
