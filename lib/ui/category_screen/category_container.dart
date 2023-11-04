import 'package:flutter/material.dart';
import 'package:movies_app/data/model/category_item.dart';
import 'package:movies_app/ui/category_screen/category_item.dart';
import 'package:movies_app/ui/movies_screen/movie_container.dart';

import '../../data/model/genres_response.dart';

class CategoryContainer extends StatelessWidget {
  List<Genres>? categoryList;

  CategoryContainer({required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browse Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieContainer(
                                  categoryName: categoryList![index].name!,
                                  categoryId: '${categoryList![index].id!}',
                                )));
                  },
                  child: CategoryItemWidget(
                    name: categoryList![index].name!,
                    assetImage: CategoryModel.categoryList[index].assetImage,
                  ),
                ),
                itemCount: categoryList!.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
