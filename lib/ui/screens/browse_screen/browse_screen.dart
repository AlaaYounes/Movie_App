import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/model/genres_response.dart';
import 'package:movies_app/ui/category_screen/category_container.dart';
import 'package:movies_app/ui/category_screen/cubit/category_cubit.dart';
import 'package:movies_app/ui/category_screen/cubit/category_states.dart';
import 'package:movies_app/utils/injection/injection.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  CategoryViewModel viewModel =
      CategoryViewModel(categoryUseCase: injectGetCategoryUseCase());

  @override
  void initState() {
    super.initState();
    viewModel.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryViewModel, CategoryStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is CategoryErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.getCategory();
                    },
                    child: const Text('try again'),
                  ),
                ],
              ),
            );
          } else if (state is CategorySuccessState) {
            List<Genres>? categoryList = state.response;
            return CategoryContainer(categoryList: categoryList);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
