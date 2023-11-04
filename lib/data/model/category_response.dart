import 'package:movies_app/data/model/genres_response.dart';

class CategoryResponse {
  CategoryResponse({
    this.genres,
    this.status_message,
    this.success,
  });

  CategoryResponse.fromJson(dynamic json) {
    status_message = json['status_message'];
    success = json['success'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genres.fromJson(v));
      });
    }
  }

  List<Genres>? genres;
  String? status_message;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_message'] = status_message;
    map['success'] = success;

    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
