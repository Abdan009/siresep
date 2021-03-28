part of 'services.dart';

class FavoriteServices {
  static CollectionReference _favoriteServices =
      FirebaseFirestore.instance.collection('favorite');
  static Future<void> updateFavorite(Favorite favorite) async {
    return await _favoriteServices.doc(favorite.id).set(favorite.toJson());
  }

  static List<Favorite> _getFavoriteColl(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((document) => Favorite.fromSnapshot(document))
        .toList();
  }

  static Stream<List<Favorite>> getMyFavoriteColl(String idUser) {
    return _favoriteServices
        .where('idUser', isEqualTo: idUser)
        .snapshots()
        .map(_getFavoriteColl);
  }

  static Future<void> deleteFavorite(String idUser, String idResep) async {
    await _favoriteServices
        .where('idUser', isEqualTo: idUser)
        .where('idResep', isEqualTo: idResep)
        .get()
        .then((snapshot) => snapshot.docs
            .map(
              (e) => e.reference.delete(),
            )
            .first);
  }
}
