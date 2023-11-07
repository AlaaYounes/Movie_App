import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/data/model/watchList_movie_response.dart';

class FirebaseManager {
  static CollectionReference<WatchListMovie> getWatchListCollection() {
    return FirebaseFirestore.instance.collection('bookmark').withConverter(
        fromFirestore: (snapshot, options) =>
            WatchListMovie.fromJson(snapshot.data()!),
        toFirestore: (movie, options) => movie.toJson());
  }

  static Future<void> addMovieToFireStore(WatchListMovie watchListMovie) async {
    var movieCollection = getWatchListCollection();
    await movieCollection.add(watchListMovie);
  }

  static Future<List<WatchListMovie>> getMoviesFromFireStore() async {
    var getWatchlistCollection = getWatchListCollection();
    var querySnapShot = await getWatchlistCollection.get();
    return querySnapShot.docs.map((e) => e.data()).toList();
  }

  static Future<void> deleteWatchListMovie(WatchListMovie movie) async {
    print('hello from delete');
    return await getWatchListCollection().doc('${movie.id}').delete();
  }
}
