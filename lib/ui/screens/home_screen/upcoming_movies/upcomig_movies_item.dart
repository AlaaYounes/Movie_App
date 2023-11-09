import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/api_constants.dart';

import '../../../../data/model/upcoming_movies_response.dart';

class UpcomingMoviesItem extends StatelessWidget {
  UpcomingMovie movie;

  UpcomingMoviesItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: 13.h),
      height: 150.h,
      width: 135.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: CachedNetworkImage(
          imageUrl: ApiConstants.baseImage + movie.posterPath!,
          width: double.infinity,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
          errorWidget: (context, url, child) => const Icon(Icons.error)),
    );
  }
}
