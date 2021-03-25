part of 'services.dart';

class ResepServices {
  static CollectionReference _resepServices =
      FirebaseFirestore.instance.collection('resep');

  static Future<void> updateResep(Resep resep) async {
    await _resepServices.doc(resep.id).set(resep.toJson());
  }

  static List<Resep> _getResepColl(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((document) => Resep.fromSnapshot(document))
        .toList();
  }

  static Stream<List<Resep>> getMyResepColl(String idUser) {
    return _resepServices
        .where('idUser', isEqualTo: idUser)
        .snapshots()
        .map(_getResepColl);
  }

  static Stream<List<Resep>> getResepColl() {
    return _resepServices.snapshots().map(_getResepColl);
  }

  static Future<void> deleteResep(String id) {
    return _resepServices.doc(id).delete();
  }

  //----------------------------------------------------

  static Stream<List<Resep>> getMyResepCollFavorite(String idUser) {
    return Rx.combineLatest3(
        getMyResepColl(idUser),
        FavoriteServices.getMyFavoriteColl(idUser),
        UsersServices.getUserDoc(idUser),
        (List<Resep> listResep, List<Favorite> listFavorite, Users user) {
      return listResep.map((resep) {
        Favorite favorite = listFavorite
            .firstWhere((element) => element.idResep == resep.id, orElse: null);
        return resep.copyWith(
            isFavorite: (favorite != null) ? true : false, user: user);
      }).toList();
    });
  }

  static Stream<List<Resep>> getResepCollFavorite(String idUser) {
    return Rx.combineLatest3(
        getResepColl(),
        FavoriteServices.getMyFavoriteColl(idUser),
        UsersServices.getUserDoc(idUser),
        (List<Resep> listResep, List<Favorite> listFavorite, Users user) {
      return listResep.map((resep) {
        Favorite favorite = listFavorite
            .firstWhere((element) => element.idResep == resep.id, orElse: null);
        return resep.copyWith(
            isFavorite: (favorite != null) ? true : false, user: user);
      }).toList();
    });
  }

  static Stream<List<Resep>> getMyResepFavorite(String idUser) {
    return Rx.combineLatest3(
        getResepColl(),
        FavoriteServices.getMyFavoriteColl(idUser),
        UsersServices.getUserDoc(idUser),
        (List<Resep> listResep, List<Favorite> listFavorite, Users user) {
      return listFavorite.map((favorite) {
        Resep resep = listResep.firstWhere(
            (element) => element.id == favorite.idResep,
            orElse: null);
        return resep.copyWith(user: user);
      }).toList();
    });
  }
}
