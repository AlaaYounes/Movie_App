import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/data/api/api_constants.dart';
import 'package:movies_app/data/model/category_response.dart';
import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<CategoryResponse> getCategory() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.categoryApi,
        {'api_key': ApiConstants.apiKey});
    try {
      var response = await http.get(url);
      return CategoryResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw (e.toString());
    }
  }

  getMovieByCategoryId(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.movieListApi,
        {'api_key': ApiConstants.apiKey, 'with_genres': categoryId});
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MovieListResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw (e.toString());
    }
  }

  getMovieDetails(String movieId) async {
    Uri url = Uri.https(
        ApiConstants.baseUrl, ApiConstants.movieDetailsApi + '/${movieId}', {
      'api_key': ApiConstants.apiKey,
    });
    try {
      var response = await http.get(url);
      return MovieDetailsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw (e.toString());
    }
  }
}
