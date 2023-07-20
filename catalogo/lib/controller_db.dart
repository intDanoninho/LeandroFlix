import 'package:catalogo/database.dart';
import 'package:catalogo/model_video.dart';
import 'package:sqflite/sqflite.dart';

class DbControls {
  late Database db;

  criarGenero(String nome) async {
    Database? db = await DatabaseHelper().db;

    await db!.insert('genre', {'name': nome});
  }

  criarVideo(
      String nome,
      String descripiton,
      int type,
      String ageRestriction,
      int durationMinutes,
      String thumbnailImageId,
      String releaseDate,
      List<int> genres,
      {int id = -1}) async {
    Database? db = await DatabaseHelper().db;

    dynamic result = await db!.insert('video', {
      'name': nome,
      'description': descripiton,
      'type': type,
      'ageRestriction': ageRestriction,
      'durationMinutes': durationMinutes,
      'thumbnailImageId': thumbnailImageId,
      'releaseDate': releaseDate,
    });

    //print("Filme: $result adicionado com sucesso!");

    for (var genre in genres) {
      await db.insert('video_genre', {'videoid': result, 'genreid': genre});
    }

    if (id != -1) {
      await db.insert('user_video', {'userid': id, 'videoid': result});
    }
  }

  editarVideo(Video video, List<int> genres) async {
    Database? db = await DatabaseHelper().db;

    await db!.update(
        'video',
        {
          'name': video.name,
          'description': video.description,
          'type': video.type,
          'ageRestriction': video.ageRestriction,
          'durationMinutes': video.durationMinutes,
          'thumbnailImageId': video.thumbnailImageId,
          'releaseDate': video.releaseDate,
        },
        where: 'id = ?',
        whereArgs: [video.id]);

    await db.delete('video_genre', where: 'videoid = ?', whereArgs: [video.id]);

    for (var genre in genres) {
      await db.insert('video_genre', {'videoid': video.id, 'genreid': genre});
    }
  }

  criarBase() async {
    criarGenero("Ação"); //id 1
    criarGenero("Aventura"); //id 2
    criarGenero("Comédia"); //id 3
    criarGenero("Drama"); //id 4
    criarGenero("Ficção Científica"); //id 5
    criarGenero("Romance"); //id 6
    criarGenero("Terror"); //id 7
    criarGenero("Suspense"); //id 8
    criarGenero("Musical"); //id 9
    criarGenero("Animação"); //id 10

    criarVideo("O Rei Leão", "Filme de animação", 0, "Livre", 88,
        "thumb/ReiLeao.jpg", "1994-06-15", [10, 2, 3, 9]);
    criarVideo("O Auto da Compadecida", "Filme de comédia", 0, "Livre", 104,
        "thumb/O_auto_da_compadecida.jpg", "2000-09-15", [2, 3]);
    criarVideo(
        "Cidade de Deus",
        "O jovem Buscapé, vivendo na cidade de Deus, acaba se distanciando do crime por causa de seu talento como fotógrafo, seguindo caminho por sua profissão e analisando o dia-a-dia da favela",
        0,
        "16 anos",
        130,
        "thumb/CidadedeDeus.jpg",
        "2002-08-30",
        [4, 8]);
    criarVideo(
        "Tropa de Elite",
        "O cotidiano de um grupo de policials da Polícia Militar do Rio de Janeiro e do BOPE, mostrando a corrupção na estrutura da primeira instituição.",
        0,
        "16 anos",
        115,
        "thumb/TropaDeElite.jpg",
        "2007-10-12",
        [1, 4, 8]);
    criarVideo(
        "Central do Brasil",
        "Uma mulher que trabalha escrevendo cartas no centro da cidade do Rio de Janeiro conhece Josué, um menino que tenta encontrar o pai que nunca conheceu.",
        0,
        "12 anos",
        113,
        "thumb/CentralDoBrasil.jpg",
        "1998-01-16",
        [4]);
    criarVideo(
        "Cidade Invisivel",
        "Um detetive se envolve em uma investigação de assassinato e acaba entrando num confronto entre o mundo que já conhece e um submundo habitado por criaturas míticas e folclóricas.",
        1,
        "16 anos",
        40,
        "thumb/CidadeInvisivel.jpg",
        "2021-02-05",
        [1, 4, 8]);
    criarVideo(
        "Bom dia, Verônica",
        "Após presenciar um suicídio, a escrivã de polícia Verônica Torres (Tainá Müller) precisa lutar contra os traumas de seu passado e acaba tomando uma arriscada decisão: usar toda a sua habilidade investigativa para ajudar duas mulheres desconhecidas.",
        1,
        "16 anos",
        40,
        "thumb/BomDia.jpg",
        "2020-10-01",
        [1, 4, 8]);
    criarVideo(
        "O Gambito da Rainha",
        "Em um orfanato no estado de Kentucky, nos anos 1950, uma garota descobre um talento surpreendente para o xadrez enquanto luta contra o vício.",
        1,
        "Livre",
        60,
        "thumb/Gambito.jpg",
        "2020-10-23",
        [4, 8]);
    criarVideo(
        "O Poço",
        "Em uma prisão onde os detentos dos andares de cima comem melhor do que os que estão abaixo, um homem decide fazer algo para mudar a situação.",
        0,
        "16 anos",
        94,
        "thumb/OPoco.jpg",
        "2019-11-08",
        [5, 8, 7]);
    criarVideo(
        "Irmão do Jorel",
        "Jorel é o garoto mais popular da escola e do bairro. Ele é bonito e tem cabelos longos e sedosos. Mas esta história não é sobre ele; é sobre seu irmão - cujo nome é um mistério. Filho de uma excêntrica família de acumuladores, ele quase não recebe atenção, até descobrir uma maneira de sair das sombras de Jorel.",
        1,
        "Livre",
        11,
        "thumb/IrmaoJorel.jpg",
        "2014-09-22",
        [10]);
    criarVideo(
        "Rick and Morty",
        "Rick é um velho mentalmente desequilibrado, mas dotado de um enorme talento científico, que recentemente se reconectou com sua família. Ele passa a maior parte do tempo envolvido em aventuras perigosas pelo espaço e em universos alternativos, sempre acompanhado de seu pequeno neto Morty. Toda essa confusão, aliada à já instável vida familiar de Morty, começa a causar muitos problemas com os seus familiares e a escola de Morty.",
        1,
        "16 anos",
        22,
        "thumb/RickeMorty.jpg",
        "2013-12-02",
        [2, 3, 5, 10]);
  }
}
