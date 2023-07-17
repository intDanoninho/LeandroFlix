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
}
