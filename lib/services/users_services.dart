part of 'services.dart';

class UsersServices {
  static CollectionReference _usersServices =
      FirebaseFirestore.instance.collection('users');
  static Future<void> updateUser(Users user) async {
    try {
      await _usersServices.doc(user.id).set(
            user.toJson(),
          );
    } on FirebaseException catch (e) {
      print('Terjadi error : ' + e.message);
    }
  }

  static Future<Users> getUser(String id) async {
    try {
      return await _usersServices
          .doc(id)
          .get()
          .then(
            (document) => Users.fromSnapshot(document),
          )
          .catchError((e) {
        print("GET USER : " + e.toString());
        return null;
      });
    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
  }

  static Users _getUserDoc(DocumentSnapshot document) {
    return Users.fromSnapshot(document);
  }

  static Stream<Users> getUserDoc(String id) {
    return _usersServices.doc(id).snapshots().map(_getUserDoc);
  }
}
