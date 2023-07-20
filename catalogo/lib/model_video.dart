class Video {
  final int id;
  String name;
  String description;
  int type;
  String ageRestriction;
  int durationMinutes;
  String thumbnailImageId;
  String releaseDate;

  Video({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.ageRestriction,
    required this.durationMinutes,
    required this.thumbnailImageId,
    required this.releaseDate,
  });

  void update(
      {required String name,
      required String description,
      required int type,
      required String ageRestriction,
      required String durationMinutes,
      required String releaseDate,
      required List<int> genres}) {
    this.name = name;
    this.description = description;
    this.type = type;
    this.ageRestriction = ageRestriction;
    this.durationMinutes = int.parse(durationMinutes);
    this.releaseDate = releaseDate;
  }
}
