import 'package:catalogo/model_user.dart';
import 'package:catalogo/model_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyVideos extends StatefulWidget {
  final User user;
  const MyVideos(this.user, {super.key});

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  List<Video> getMyVideos() {
    return [];
  }

  Widget barraSuperior() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.add_circle_outline_sharp),
                  Text("Criar Video"),
                ],
              )),
          const Padding(padding: EdgeInsets.all(10.0)),
          ElevatedButton(
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
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: getMyVideos().map((video) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(video.name),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            //Image.network(
                                            //video.thumbnailImageId),
                                            const Padding(
                                                padding: EdgeInsets.all(10.0)),
                                            Text(video.description),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  //Image.network(video.thumbnailImageId),
                                  Text(video.name),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
