part of 'extensions.dart';

extension FirebaseAdminExtension on User {
  Users convertToAdmin() => Users(
      id: this.uid,
      name: this.displayName,
      email: this.email,
      phoneNumber: this.phoneNumber ?? '',
      photoURL: this.photoURL ?? '');
}
