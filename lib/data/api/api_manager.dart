import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/data/api/api_constants.dart';
import 'package:movies_app/data/model/category_response.dart';
import 'package:movies_app/data/model/movie_details_response.dart';
import 'package:movies_app/data/model/movie_response.dart';
import 'package:movies_app/data/model/upcoming_movies_response.dart';

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
        ApiConstants.baseUrl, '${ApiConstants.movieDetailsApi}/$movieId', {
      'api_key': ApiConstants.apiKey,
    });
    try {
      var response = await http.get(url);
      return MovieDetailsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw (e.toString());
    }
  }

  searchForMovieByName(String name) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.searchApi, {
      'api_key': ApiConstants.apiKey,
      'query': name,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MovieListResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<UpcomingMoviesResponse> getUpcomingMovies() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.upcomingApi, {
      'api_key': '61e02f380f7292131dd416f8e1e1d5ac',
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return UpcomingMoviesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieListResponse> getRecommendedMovies() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.recommendedApi, {
      'api_key': '61e02f380f7292131dd416f8e1e1d5ac',
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return MovieListResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieListResponse> getPopularMovies() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.popularApi,
        {'api_key': ApiConstants.apiKey, 'page': '1'});
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return MovieListResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
