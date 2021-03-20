part of 'shared.dart';

Future<File> getImage() async {
  final _picker = ImagePicker();
  PickedFile pickedFile;
  pickedFile = await _picker.getImage(
      maxHeight: 1200,
      maxWidth: 630,
      // imageQuality: 60,
      source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    print('No image selected');
    return null;
  }
}

Future<String> uploadImage(File image, String folder, String name) async {
  String fileName = basename(image.path);
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child(folder)
      .child('$name' + '_' + fileName);
  firebase_storage.UploadTask task = ref.putFile(image);

  firebase_storage.TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}

Future<void> deleteImage(String urlImage) async {
  var fileUrl = Uri.decodeFull(basename('$urlImage'))
      .replaceAll(new RegExp(r'(\?alt).*'), "");

  final firebase_storage.Reference firebaseStorageRef =
      firebase_storage.FirebaseStorage.instance.ref().child(fileUrl);
  await firebaseStorageRef.delete();
}

void flushbar(String message, BuildContext context,
    {FlushbarPosition position, Color backgroundColor}) {
  Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: position ?? FlushbarPosition.TOP,
    backgroundColor: backgroundColor ?? Color(0xFFFF5C83),
    message: message,
  )..show(context);
}

Widget loading(double sized) {
  return CircularProgressIndicator(
    strokeWidth: sized,
    backgroundColor: mainColor,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
  );
}

PreferredSizeWidget appBar(String title, {List<Widget> actions}) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: fontTitle.copyWith(fontSize: 20),
    ),
    actions: actions,
  );
}

ProgressDialog loadingDialog(BuildContext context, {String message}) {
  ProgressDialog loading = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false);

  loading.style(
    message: message ?? "Harap tunggu...",
    // progressWidget:
  );
  return loading;
}
