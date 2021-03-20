part of 'models.dart';

class Users extends Equatable {
  final String id, name, email, phoneNumber, photoURL;
  Users(
      {this.id,
      @required this.name,
      @required this.email,
      @required this.phoneNumber,
      @required this.photoURL});
  @override
  List<Object> get props => [id, name, email, phoneNumber, photoURL];

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    return Users(
      id: snapshot.id,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phoneNumber: snapshot.data()['phoneNumber'],
      photoURL: snapshot.data()['photoURL'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL
    };
  }
}
