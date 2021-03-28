part of '../pages.dart';

class DetailResepPage extends StatefulWidget {
  final Resep resep;
  DetailResepPage(this.resep);

  @override
  _DetailResepPageState createState() => _DetailResepPageState();
}

class _DetailResepPageState extends State<DetailResepPage> {
  bool isViewFulDesk = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        'Detail Resep',
        actions: [
          if (widget.resep != null)
            Center(
              child: GestureDetector(
                onTap: () async {
                  loadingDialog(context).show();
                  await ResepServices.deleteResep(widget.resep.id)
                      .then((value) {
                    loadingDialog(context).hide();
                    Get.back();
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Text(
                    'Hapus',
                    style: blackTextFont.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (_, userState) => StreamBuilder<Resep>(
          stream: ResepServices.getResepDocRx(
              widget.resep.id, (userState as UsersLoaded).user.id),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  body(snapshot.data, (userState as UsersLoaded).user.id),
                  if ((userState as UsersLoaded).user.id == widget.resep.idUser)
                    buildTombol(context, snapshot.data),
                ],
              );
            } else {
              return Center(
                child: loading(4.0),
              );
            }
          },
        ),
      ),
    );
  }

  Align buildTombol(BuildContext context, Resep resep) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.0, 4.0),
            blurRadius: 10.0,
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 43,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: mainColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(51),
                  ),
                ),
                child: Text(
                  (widget.resep == null) ? "Tambahkan" : "Edit",
                  style: whiteTextFont.copyWith(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  Get.to(
                    () => UpdateResepPage(
                      resep: resep,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container body(Resep resep, String idUser) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: Get.width,
            height: 230,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(resep.photo), fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            resep.title,
                            style: blackTextFont.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite,
                            color:
                                (resep.isFavorite) ? Colors.red : accentColor2),
                        onPressed: () async {
                          if (!resep.isFavorite) {
                            Favorite favorite =
                                Favorite(idUser: idUser, idResep: resep.id);
                            await FavoriteServices.updateFavorite(favorite);
                          } else {
                            await FavoriteServices.deleteFavorite(
                                idUser, resep.id);
                          }
                        },
                      )
                    ],
                  ),
                ),
                Text("Dibuat oleh : " + resep.user.name, style: blackTextFont),
                Text("Upload : " + resep.timecreate.dateAndTimeNumber,
                    style: blackTextFont),
                Divider(height: 10, thickness: 3),
                Text(
                  'Deskripsi',
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resep.desk,
                        textAlign: TextAlign.start,
                        maxLines: isViewFulDesk ? null : 10,
                        overflow: isViewFulDesk ? null : TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              if (isViewFulDesk) {
                                isViewFulDesk = false;
                              } else {
                                isViewFulDesk = true;
                              }
                            },
                          );
                        },
                        child: Text(
                          isViewFulDesk
                              ? 'Tampilkan Sedikit'
                              : 'Baca Selengkapnya ...',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
