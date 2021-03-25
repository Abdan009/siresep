part of 'widgets.dart';

class CardResepWidget extends StatelessWidget {
  final Resep resep;
  CardResepWidget(this.resep);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailResepPage(resep));
      },
      child: Container(
        height: Get.height / 3,
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
                    image: NetworkImage(resep.photo), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 5,
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
                                resep.title,
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          (!resep.isFavorite)
                              ? IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: (resep.isFavorite)
                                          ? Colors.red
                                          : accentColor2),
                                  onPressed: () async {
                                    if (!resep.isFavorite) {
                                      Favorite favorite = Favorite(
                                          idUser: (userState as UsersLoaded)
                                              .user
                                              .id
                                              .toString(),
                                          idResep: resep.id);
                                      await FavoriteServices.updateFavorite(
                                          favorite);
                                    } else {
                                      await FavoriteServices.deleteFavorite(
                                          resep.id);
                                    }
                                  },
                                )
                              : loading(1),
                        ],
                      ),
                    ),
                    Text("Dibuat Oleh : " + resep.user.name,
                        style: blackTextFont),
                    Text("Rilis : " + resep.timecreate.dateAndTimeNumber,
                        style: blackTextFont),
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
