class CategoryEntity {
  CategoryEntity({
    this.genres,
    this.status_message,
    this.success,
  });

  List<Genres>? genres;
  String? status_message;
  bool? success;
}

class Genres {
  Genres({
    this.id,
    this.name,
  });

  int? id;
  String? name;
}
