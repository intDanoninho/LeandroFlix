import 'package:catalogo/movie_page.dart';
import 'package:catalogo/model_video.dart';
import 'package:catalogo/model_videogenero.dart';
import 'package:catalogo/signin.dart';
import 'package:catalogo/meus_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'model_genero.dart';
import 'model_user.dart';

class Catalogo extends StatefulWidget {
  final User user;
  const Catalogo(this.user, {super.key});

  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  List<Video> _videos = [];
  List<Genero> _generos = [];
  List<VideoGenero> _videoGeneros = [];
  final List<int> _selectedGeneros = [];
  int _selectedType = 2;

  late Database db;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    Database? db = await DatabaseHelper().db;

    final List<Map<String, dynamic>> genreData =
        await db!.rawQuery('SELECT * FROM genre');
    final List<Map<String, dynamic>> videoGenreData =
        await db.rawQuery('SELECT * FROM video_genre');
    final List<Map<String, dynamic>> videoData =
        await db.rawQuery('SELECT * FROM video');

    final List<Video> videos = videoData.map((data) {
      return Video(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        type: data['type'],
        ageRestriction: data['ageRestriction'],
        durationMinutes: data['durationMinutes'],
        thumbnailImageId: data['thumbnailImageId'],
        releaseDate: data['releaseDate'],
      );
    }).toList();

    final List<Genero> genres = genreData.map((data) {
      return Genero(id: data['id'], name: data['name']);
    }).toList();

    final List<VideoGenero> videoGenres = videoGenreData.map((data) {
      return VideoGenero(
        id: data['id'],
        videoId: data['videoid'],
        genreId: data['genreid'],
      );
    }).toList();
    if (mounted) {
      setState(() {
        _videos = videos;
        _generos = genres;
        _videoGeneros = videoGenres;
      });
    }
  }

  dynamic filtro() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Selecione os Filtros"),
              content: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Tipos",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0)),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      Column(
                        children: [
                          RadioListTile(
                            title: const Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 60)),
                                Text("Todos"),
                              ],
                            ),
                            value: 2,
                            groupValue: _selectedType,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 60)),
                                Text("Filmes"),
                              ],
                            ),
                            value: 0,
                            groupValue: _selectedType,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 60)),
                                Text("Series"),
                              ],
                            ),
                            value: 1,
                            groupValue: _selectedType,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const Text("Generos",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0)),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      Column(
                        children: _generos.map((genero) {
                          return CheckboxListTile(
                            title: Text(
                              genero.name,
                            ),
                            value: _selectedGeneros.contains(genero.id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null && value) {
                                  _selectedGeneros.add(genero.id);
                                } else {
                                  _selectedGeneros.remove(genero.id);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ]),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateParentState();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  _updateParentState() {
    setState(() {});
  }

  List<Video> getVideoFiltrado() {
    _initDatabase();
    if (_selectedType == 0) {
      if (_selectedGeneros.isEmpty) {
        return _videos.where((video) => video.type == 0).toList();
      }

      List<Video> videos = [];
      for (VideoGenero videoGenero in _videoGeneros) {
        if (_selectedGeneros.contains(videoGenero.genreId)) {
          if (!videos.contains(_getVideoById(videoGenero.videoId))) {
            if (_getVideoById(videoGenero.videoId).type == 0) {
              videos.add(_getVideoById(videoGenero.videoId));
            }
          }
        }
      }
      return videos;
    } else if (_selectedType == 1) {
      if (_selectedGeneros.isEmpty) {
        return _videos.where((video) => video.type == 1).toList();
      }

      List<Video> videos = [];
      for (VideoGenero videoGenero in _videoGeneros) {
        if (_selectedGeneros.contains(videoGenero.genreId)) {
          if (!videos.contains(_getVideoById(videoGenero.videoId))) {
            if (_getVideoById(videoGenero.videoId).type == 1) {
              videos.add(_getVideoById(videoGenero.videoId));
            }
          }
        }
      }
      return videos;
    } else if (_selectedType == 2) {
      if (_selectedGeneros.isEmpty) {
        return _videos;
      }
      List<Video> videos = [];
      for (VideoGenero videoGenero in _videoGeneros) {
        if (_selectedGeneros.contains(videoGenero.genreId)) {
          if (!videos.contains(_getVideoById(videoGenero.videoId))) {
            videos.add(_getVideoById(videoGenero.videoId));
          }
        }
      }
      return videos;
    }

    return [];
  }

  Video _getVideoById(int id) {
    for (Video video in _videos) {
      if (video.id == id) {
        return video;
      }
    }
    return Video(
        id: -1,
        name: "",
        description: "",
        type: 0,
        ageRestriction: "",
        durationMinutes: 0,
        thumbnailImageId: "",
        releaseDate: "");
  }

  Widget barraSuperior() {
    if (widget.user.id == -1) {
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
                  MaterialPageRoute(builder: (context) => const Signin()),
                );
              },
              child: const Row(children: [
                Icon(Icons.add_circle_outline_outlined),
                Text('Cadastrar')
              ]),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(children: [
                Icon(Icons.login),
                Text("Entrar"),
              ]),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10.0),
        color: const Color(0xFF57585a),
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
                        settings: const RouteSettings(name: '/meus_videos'),
                        builder: (
                          context,
                        ) =>
                            MyVideos(widget.user)),
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.video_collection_rounded),
                    Text("Meus Videos"),
                  ],
                )),
            const Padding(padding: EdgeInsets.all(10.0)),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(children: [
                Icon(Icons.logout),
                Text("Sair"),
              ]),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LeandroFlix"),
        actions: [
          IconButton(
            onPressed: () {
              filtro();
            },
            icon: const Icon(Icons.filter_alt_outlined),
          )
        ],
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
                        children: getVideoFiltrado().map((video) {
                          return GestureDetector(
                            onTap: () {
                              //print(video.thumbnailImageId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MoviePage(video)));
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    color: const Color(0xFF57585a),
                                    height: 156,
                                    width: 200,
                                    child: Image.asset(
                                      video.thumbnailImageId,
                                    ),
                                  ),
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
