class WatchListMovie {
  static String collectionPath = 'bookmark';
  String? id;
  String? mId;
  String? title;
  String? imagePath;
  String? year;
  bool? isWatched;

  WatchListMovie(
      {this.id,
      this.mId,
      required this.isWatched,
      required this.title,
      required this.year,
      required this.imagePath});

  WatchListMovie.fromJson(Map<String, dynamic> map)
      : this(
    id: map['id'],
          mId: map['mId'],
          title: map['title'],
          year: map['year'],
          imagePath: map['imagePath'],
          isWatched: map['isWatched'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mId': mId,
      'title': title,
      'year': year,
      'imagePath': imagePath,
      'isWatched': isWatched,
    };
  }
}
