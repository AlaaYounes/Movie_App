import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';

class FirebaseManager {
  FirebaseManager._();

  static FirebaseManager? _instance;

  static FirebaseManager getInstance() {
    _instance ??= FirebaseManager._();
    return _instance!;
  }

  static CollectionReference<WatchListMovie> getWatchListCollection() {
    return FirebaseFirestore.instance
        .collection(WatchListMovie.collectionPath)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                WatchListMovie.fromJson(snapshot.data()!),
            toFirestore: (movie, options) => movie.toJson());
  }

  Future<void> addMovieToFireStore(WatchListMovie watchListMovie) async {
    var movieCollection = getWatchListCollection();
    var document = movieCollection.doc();
    watchListMovie.id = document.id;
    return await document.set(watchListMovie);
  }

  Future<List<WatchListMovie>> getMoviesFromFireStore() async {
    var getWatchlistCollection = getWatchListCollection();
    var querySnapShot = await getWatchlistCollection.get();
    return querySnapShot.docs.map((e) => e.data()).toList();
  }

  Future<void> deleteWatchListMovie(String id) async {
    var getWatchlistCollection = getWatchListCollection();
    return await getWatchlistCollection.doc(id).delete();
  }
}
