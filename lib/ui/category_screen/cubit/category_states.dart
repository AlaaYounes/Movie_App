import '../../../data/model/genres_response.dart';

abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}

class CategoryErrorState extends CategoryStates {
  String errorMessage;

  CategoryErrorState({required this.errorMessage});
}

class CategorySuccessState extends CategoryStates {
  List<Genres>? response;

  CategorySuccessState({required this.response});
}
