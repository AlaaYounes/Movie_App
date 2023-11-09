import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/useCase/category/get_category.dart';
import 'package:movies_app/ui/category_screen/cubit/category_states.dart';

class CategoryViewModel extends Cubit<CategoryStates> {
  GetCategoryUseCase categoryUseCase;

  CategoryViewModel({required this.categoryUseCase})
      : super(CategoryInitialState());

  getCategory() async {
    try {
      var response = await categoryUseCase.invoke();
      if (response.success = false) {
        emit(CategoryErrorState(errorMessage: response.status_message!));
      } else {
        emit(CategorySuccessState(response: response.genres));
      }
    } catch (e) {
      emit(CategoryErrorState(errorMessage: e.toString()));
    }
  }
}
