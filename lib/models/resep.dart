part of 'models.dart';

class Resep extends Equatable {
  final String id, idUser, title, desk, photo;
  final DateTime timecreate;
  final bool isFavorite;
  final Users user;
  Resep(
      {this.id,
      @required this.idUser,
      @required this.title,
      @required this.desk,
      @required this.photo,
      @required this.timecreate,
      this.user,
      this.isFavorite});
  @override
  List<Object> get props =>
      [id, idUser, title, desk, photo, timecreate, isFavorite, user];

  Resep copyWith(
      {String title, String desk, String photo, bool isFavorite, Users user}) {
    return Resep(
        id: this.id,
        idUser: this.idUser,
        title: title ?? this.title,
        desk: desk ?? this.desk,
        photo: photo ?? this.photo,
        timecreate: this.timecreate,
        isFavorite: isFavorite ?? this.isFavorite,
        user: user ?? this.user);
  }

  factory Resep.fromSnapshot(DocumentSnapshot snapshot) {
    return Resep(
        id: snapshot.id,
        idUser: snapshot.data()['idUser'],
        title: snapshot.data()['title'],
        desk: snapshot.data()['desk'],
        photo: snapshot.data()['photo'],
        timecreate: snapshot.data()['timecreate'].toDate());
  }
  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'title': title,
      'desk': desk,
      'photo': photo,
      'timecreate': timecreate
    };
  }
}
