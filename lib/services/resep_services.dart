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

  static Resep _getResepDoc(DocumentSnapshot document) {
    return Resep.fromSnapshot(document);
  }

  static Stream<Resep> getResepDoc(String id) {
    return _resepServices.doc(id).snapshots().map(_getResepDoc);
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

  static Stream<Resep> getResepDocRx(String idResep, String idUser) {
    return Rx.combineLatest3(
      getResepDoc(idResep),
      FavoriteServices.getMyFavoriteColl(idUser),
      UsersServices.getUserDoc(idUser),
      (Resep resep, List<Favorite> listFavorite, Users user) {
        return resep.copyWith(
            isFavorite:
                listFavorite.any((element) => element.idResep == resep.id),
            user: user);
      },
    );
  }

  static Stream<List<Resep>> getMyResepCollCom(String idUser) {
    return Rx.combineLatest3(
      getMyResepColl(idUser),
      FavoriteServices.getMyFavoriteColl(idUser),
      UsersServices.getUserDoc(idUser),
      (List<Resep> listResep, List<Favorite> listFavorite, Users user) {
        return listResep.map(
          (resep) {
            return resep.copyWith(
                isFavorite:
                    listFavorite.any((element) => element.idResep == resep.id),
                user: user);
          },
        ).toList();
      },
    );
  }

  static Stream<List<Resep>> getResepCollCom(String idUser) {
    return Rx.combineLatest3(
      getResepColl(),
      FavoriteServices.getMyFavoriteColl(idUser),
      UsersServices.getUserDoc(idUser),
      (List<Resep> listResep, List<Favorite> listFavorite, Users user) {
        return listResep.map(
          (resep) {
            return resep.copyWith(
                isFavorite:
                    listFavorite.any((element) => element.idResep == resep.id),
                user: user);
          },
        ).toList();
      },
    );
  }

  static Stream<List<Resep>> getMyResepFavorite(String idUser) {
    return Rx.combineLatest3(
      getResepColl(),
      FavoriteServices.getMyFavoriteColl(idUser),
      UsersServices.getUserDoc(idUser),
      (List<Resep> listResep, List<Favorite> listFavorite, Users user) {
        return listFavorite.map(
          (favorite) {
            Resep resep;
            if (listFavorite.isNotEmpty) {
              resep = listResep.firstWhere(
                  (element) => element.id == favorite.idResep,
                  orElse: null);
            }
            return resep.copyWith(user: user, isFavorite: true);
          },
        ).toList();
      },
    );
  }
}
