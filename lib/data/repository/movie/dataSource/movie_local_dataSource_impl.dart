import 'package:movies_app/data/firebase/local_firebase.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';
import 'package:movies_app/domain/repository/movie/movie_local_dataSource.dart';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  FirebaseManager firebaseManager;

  MovieLocalDataSourceImpl({required this.firebaseManager});

  @override
  Future<void> addMovieToWatchlist(WatchListMovie watchListMovie) {
    return firebaseManager.addMovieToFireStore(watchListMovie);
  }

  @override
  Future<void> deleteWatchListMovie(String id) {
    return firebaseManager.deleteWatchListMovie(id);
  }

  @override
  Future<List<WatchListMovie>> getMoviesFromWatchList() {
    return firebaseManager.getMoviesFromFireStore();
  }
}
