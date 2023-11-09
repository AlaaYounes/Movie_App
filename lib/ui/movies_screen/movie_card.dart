import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movies_app/data/api/api_constants.dart';
import 'package:movies_app/ui/screens/watchlist_screen/cubit.dart';
import 'package:movies_app/utils/colors.dart';

class MovieCard extends StatefulWidget {
  String? id;
  String imageUrl;
  String movieName;
  String year;
  bool? isWatched;
  bool? watchlistScreen;

  MovieCard({
    this.id,
    required this.imageUrl,
    required this.movieName,
    required this.year,
    this.isWatched,
    this.watchlistScreen,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.watchlistScreen == true ? false : true,
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (context) {
                WatchListViewModel().deleteWatchListMovie(widget.id.toString());
                WatchListViewModel().getWatchListMovies();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * .3,
                    height: MediaQuery.of(context).size.height * .2,
                    imageUrl: ApiConstants.baseImage + widget.imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Visibility(
                  visible: widget.watchlistScreen == true ? true : false,
                  child: Positioned(
                    right: MediaQuery.of(context).size.width * .195,
                    bottom: MediaQuery.of(context).size.width * .325,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: AppColor.yellowColor,
                          size: 50,
                        ),
                        Icon(
                          Icons.check,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movieName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.year,
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
