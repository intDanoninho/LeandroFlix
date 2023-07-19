import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            "thumb/BomDia.jpg",
            height: 200,
            width: double.infinity,
            fit:BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:Icon(Icons.arrow_back),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "thumb/BomDia.jpg",
                            height: 250,
                            width: 180,
                          ),
                        ),
                      ),
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical:90, horizontal: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Classificação: 16\nDuração: 88 minutos",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                
                              ),
                            ]
                          ))),
                    ],
                  ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical:20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bom Dia, Verônica',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                          Text(
                          'Após presenciar um suicídio, a escrivã de polícia Verônica Torres (Tainá Müller) precisa lutar contra os traumas de seu passado e acaba tomando uma arriscada decisão: usar toda a sua habilidade investigativa para ajudar duas mulheres desconhecidas.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    )
              ],
            ),
          ),
        ),
        ],
    ),
    );

  }
}