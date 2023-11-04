import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  String name;
  String assetImage;

  CategoryItemWidget({required this.name, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            assetImage,
          ),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
