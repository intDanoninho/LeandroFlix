import 'package:flutter/material.dart';

import 'model_user.dart';

class Catalogo extends StatefulWidget {
  final User user;
  const Catalogo(this.user, {super.key});

  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  @override
  Widget build(BuildContext context) {
    return Text("Catalogo do usuario ${widget.user.name}");
  }
}
