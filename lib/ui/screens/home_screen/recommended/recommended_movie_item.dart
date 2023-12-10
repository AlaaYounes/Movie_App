import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/api_constants.dart';
import 'package:movies_app/utils/colors.dart';

class RecommendedMovieItem extends StatelessWidget {
  dynamic movie;

  RecommendedMovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: 135.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 150.h,
              width: 135.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: ApiConstants.baseImage + movie.posterPath!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: AppColor.yellowColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${movie.voteAverage}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColor.whiteColor),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            movie.title!,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
