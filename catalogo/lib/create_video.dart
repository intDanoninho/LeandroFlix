import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'controller_db.dart';

class CreateVid extends StatefulWidget {
  final int userID;
  const CreateVid(this.userID, {super.key});

  @override
  State<CreateVid> createState() => _CreateVidState();
}

class _CreateVidState extends State<CreateVid> {
  DbControls dbControls = DbControls();
  late Database db;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int type = 0;
  final TextEditingController _ageRestrictionController =
      TextEditingController();
  final TextEditingController _durationMinutesController =
      TextEditingController();

  final TextEditingController _releaseDateController = TextEditingController();
  List<int> genres = [];

  final genresList = [
    "Ação",
    "Aventura",
    "Comédia",
    "Drama",
    "Ficção Científica",
    "Romance",
    "Terror",
    "Suspense",
    "Musical",
    "Animação"
  ];

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
                child: SingleChildScrollView(
                    child: Column(children: [
                  Form(
                    key: _formKey,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  labelText: '  Nome do filme '),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira um nome';
                                }
                                return null;
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            child: TextFormField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  labelText: '  Descrição '),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira uma descrição';
                                }
                                return null;
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                        title: const Text('Filme'),
                                        value: 0,
                                        groupValue: type,
                                        onChanged: (int? value) {
                                          setState(() {
                                            type = value!;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                      child: RadioListTile(
                                          title: const Text('Série'),
                                          value: 1,
                                          groupValue: type,
                                          onChanged: (int? value) {
                                            setState(() {
                                              type = value!;
                                            });
                                          }))
                                ])),
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            child: TextFormField(
                              controller: _ageRestrictionController,
                              decoration: const InputDecoration(
                                  labelText: '  Classificação indicativa '),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira uma classificação indicativa';
                                }
                                return null;
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: _durationMinutesController,
                              decoration: const InputDecoration(
                                  labelText: '  Duração em minutos '),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira uma duração';
                                }
                                return null;
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                            child: TextFormField(
                              controller: _releaseDateController,
                              decoration: const InputDecoration(
                                  labelText: '  Data de lançamento '),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira uma data';
                                }
                                return null;
                              },
                            )),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: genresList.map((item) {
                            int index = genresList.indexOf(item);
                            return FilterChip(
                              label: Text(item),
                              selected: genres.contains(index),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    genres.add(index);
                                  } else {
                                    genres.remove(index);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              dbControls.criarVideo(
                                  _nameController.text,
                                  _descriptionController.text,
                                  type,
                                  _ageRestrictionController.text,
                                  int.parse(_durationMinutesController.text),
                                  "thumb/sem-foto.jpg",
                                  _releaseDateController.text,
                                  genres,
                                  id: widget.userID);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Criar"),
                        ),
                      ],
                    ),
                  ),
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
