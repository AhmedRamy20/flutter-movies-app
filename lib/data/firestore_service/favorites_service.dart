import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/data/model/movie_model.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _favRef =>
      _firestore.collection('users').doc(uid).collection('favorites');

  //? Add favorite
  Future<void> addFavorite(Movie movie) async {
    await _favRef.doc(movie.id.toString()).set({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'voteAverage': movie.voteAverage,
      'overview': movie.overview,
    });
  }

  //? Remove favorite
  Future<void> removeFavorite(int movieId) async {
    await _favRef.doc(movieId.toString()).delete();
  }

  //? is fav
  Future<bool> isFavorite(int movieId) async {
    final doc = await _favRef.doc(movieId.toString()).get();
    return doc.exists;
  }

  //? all fav
  Future<List<Movie>> getFavorites() async {
    final snapshot = await _favRef.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Movie(
        id: data['id'],
        title: data['title'],
        posterPath: data['posterPath'],
        voteAverage: data['voteAverage'],
        overview: data['overview'],
      );
    }).toList();
  }

  //? stream of fav
  Stream<List<Movie>> watchFavorites() {
    return _favRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return Movie(
          id: data['id'],
          title: data['title'],
          posterPath: data['posterPath'],
          voteAverage: data['voteAverage'],
          overview: data['overview'],
        );
      }).toList();
    });
  }
}
