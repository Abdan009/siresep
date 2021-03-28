part of '../pages.dart';

class UpdateResepPage extends StatefulWidget {
  final Resep resep;
  UpdateResepPage({this.resep});

  @override
  _UpdateResepPageState createState() => _UpdateResepPageState();
}

class _UpdateResepPageState extends State<UpdateResepPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  File imageFileUpload;
  String fotoURL;
  @override
  void initState() {
    super.initState();
    if (widget.resep != null) {
      titleController.text = widget.resep.title;
      deskripsiController.text = widget.resep.desk;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        (widget.resep == null) ? 'Tambah Resep' : 'Edit Resep',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            buildGetFoto(),
            SizedBox(
              height: 20,
            ),
            FieldInputDua(titleController, 'Judul'),
            SizedBox(
              height: 10,
            ),
            FieldInputDua(
              deskripsiController,
              'Deskripsi',
              height: 300,
              textInputAction: TextInputAction.newline,
              typeText: TextInputType.multiline,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: BlocBuilder<UsersCubit, UsersState>(
                builder: (_, userState) => Container(
                  width: 190,
                  height: 43,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(51),
                        ),
                        primary: mainColor,
                        elevation: 0),
                    child: Text(
                      (widget.resep == null) ? "Tambahkan" : "Edit",
                      style:
                          whiteTextFont.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      bool isNextValidasi = false;
                      if (widget.resep == null) {
                        if (imageFileUpload == null) {
                          flushbar(
                              'Harap tambahkan foto hasil dari resep', context);
                        } else {
                          isNextValidasi = true;
                        }
                      } else {
                        isNextValidasi = true;
                      }

                      (isNextValidasi)
                          ? await nextValidasi(
                              (userState as UsersLoaded).user.id)
                          : print("ERROR- update pasar");
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  Future nextValidasi(String idUser) async {
    if (!(titleController.text.trim() != "" &&
        deskripsiController.text.trim() != "")) {
      flushbar('Harap isi seluruh data terlebih dahulu', context);
    } else {
      loadingDialog(context, message: "Mohon tunggu").show();
      bool isUploadFoto = false;
      if (imageFileUpload != null) {
        await uploadImage(
          imageFileUpload,
          'foto_resep',
          titleController.text.trim(),
        ).then(
          (value) async {
            setState(() {
              fotoURL = value;
              imageFileUpload = null;
              print("Upload Foto Berhasil");
            });
            if (widget.resep?.photo != null && widget.resep?.photo != '') {
              await deleteImage(widget.resep.photo).then(
                (value) {
                  print("Delete Sukses");
                },
              );
              //hapus foto Sebelumnya
            }
            isUploadFoto = true;
          },
        ).catchError(
          (error) {
            print("Upload image Error :");
          },
        );
      } else {
        isUploadFoto = true;
      }
      if (isUploadFoto) {
        Resep resep;
        if (widget.resep == null) {
          resep = Resep(
            idUser: idUser,
            title: titleController.text,
            desk: deskripsiController.text,
            photo: fotoURL,
            timecreate: DateTime.now(),
          );
          await ResepServices.updateResep(resep).then(
            (value) {
              loadingDialog(context).hide();
              Get.back();
            },
          ).catchError(
            (e) {
              flushbar('Terjadi kesalahan saat upload', context);
              loadingDialog(context).hide();
            },
          );
        } else {
          resep = widget.resep.copyWith(
              title: titleController.text,
              desk: deskripsiController.text,
              photo: fotoURL);
          await ResepServices.updateResep(resep).then(
            (value) {
              loadingDialog(context).hide();
              Get.back();
            },
          ).catchError(
            (e) {
              flushbar('Terjadi kesalahan saat upload', context);
              loadingDialog(context).hide();
            },
          );
        }
      }
    }
  }

  Center buildGetFoto() {
    return Center(
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FDottedLine(
              color: mainColor,
              corner: FDottedLineCorner.all(20),
              child: GestureDetector(
                onTap: () async {
                  await getImage().then((value) {
                    setState(() {
                      imageFileUpload = value;
                    });
                  });
                },
                child: Container(
                  height: Get.width / 2,
                  width: Get.width - (2 * 20),
                  decoration: BoxDecoration(
                      color: accentColor1,
                      borderRadius: BorderRadius.circular(20),
                      image: (imageFileUpload != null)
                          ? DecorationImage(
                              image: FileImage(imageFileUpload),
                              fit: BoxFit.cover)
                          : (widget.resep != null)
                              ? DecorationImage(
                                  image: NetworkImage(widget.resep?.photo),
                                  fit: BoxFit.cover)
                              : null),
                  child: (imageFileUpload == null)
                      ? Center(
                          child: Text("Foto",
                              style: greyTextFont.copyWith(
                                  fontSize: 13, color: Colors.grey)),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
