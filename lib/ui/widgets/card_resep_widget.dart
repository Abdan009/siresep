part of 'widgets.dart';

class CardResepWidget extends StatefulWidget {
  final Resep resep;
  CardResepWidget(this.resep);

  @override
  _CardResepWidgetState createState() => _CardResepWidgetState();
}

class _CardResepWidgetState extends State<CardResepWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFaforite = false;
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailResepPage(widget.resep),
        );
      },
      child: Container(
        height: (Get.height / 3) + 20,
        margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height / 3 - 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(widget.resep.photo), fit: BoxFit.cover),
              ),
            ),
            BlocBuilder<UsersCubit, UsersState>(
              builder: (_, userState) => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.resep.title,
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          (!isFaforite)
                              ? IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: (widget.resep.isFavorite)
                                          ? Colors.red
                                          : accentColor2),
                                  onPressed: () async {
                                    if (!widget.resep.isFavorite) {
                                      Favorite favorite = Favorite(
                                          idUser: (userState as UsersLoaded)
                                              .user
                                              .id
                                              .toString(),
                                          idResep: widget.resep.id);
                                      await FavoriteServices.updateFavorite(
                                          favorite);
                                    } else {
                                      await FavoriteServices.deleteFavorite(
                                          (userState as UsersLoaded)
                                              .user
                                              .id
                                              .toString(),
                                          widget.resep.id);
                                    }
                                  },
                                )
                              : SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: loading(2),
                                ),
                        ],
                      ),
                    ),
                    Text("Dibuat Oleh : " + widget.resep.user.name,
                        style: blackTextFont),
                    Text(
                        "Upload : " + widget.resep.timecreate.dateAndTimeNumber,
                        style: blackTextFont),
                    Divider(
                      height: 20,
                      thickness: 2,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
