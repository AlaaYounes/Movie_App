class WatchListMovie {
  static String collectionPath = 'watchlist';
  num? id;
  String? title;
  String? imagePath;
  String? year;
  bool? isWatched;

  WatchListMovie(
      {required this.id,
      required this.isWatched,
      required this.title,
      required this.year,
      required this.imagePath});

  WatchListMovie.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id'],
          title: map['title'],
          year: map['year'],
          imagePath: map['imagePath'],
          isWatched: map['isWatched'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'imagePath': imagePath,
      'isWatched': isWatched,
    };
  }
}
