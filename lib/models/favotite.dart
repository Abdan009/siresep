part of 'models.dart';

class Favorite extends Equatable {
  final String id, idResep, idUser;
  Favorite({
    this.id,
    @required this.idResep,
    @required this.idUser,
  });
  @override
  List<Object> get props => [id, idUser, idResep];

  factory Favorite.fromSnapshot(DocumentSnapshot snapshot) {
    return Favorite(
        id: snapshot.id,
        idResep: snapshot.data()['idResep'],
        idUser: snapshot.data()['idUser']);
  }
  Map<String, dynamic> toJson() {
    return {'idUser': idUser, 'idResep': idResep};
  }
}
