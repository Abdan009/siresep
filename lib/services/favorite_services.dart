part of 'services.dart';

class FavoriteServices {
  static CollectionReference _resepServices =
      FirebaseFirestore.instance.collection('resep');
  static CollectionReference _favoriteServices =
      FirebaseFirestore.instance.collectionGroup('favorite');
  static Future<void> updateFavorite(Favorite favorite) async {
    return await _resepServices
        .doc(favorite.idResep)
        .collection('favorite')
        .doc(favorite.id)
        .set(favorite.toJson());
  }

  static List<Favorite> _getFavoriteColl(QuerySnapshot sanpshot) {
    return sanpshot.docs
        .map((document) => Favorite.fromSnapshot(document))
        .toList();
  }

  static Stream<List<Favorite>> getMyFavoriteColl(String idUser) {
    return _favoriteServices
        .where('idUser', isEqualTo: idUser)
        .snapshots()
        .map(_getFavoriteColl);
  }

  static Future<void> deleteFavorite(String id) async {
    await _favoriteServices.doc(id).delete();
  }
}
