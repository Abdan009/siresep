part of '../pages.dart';

class MyFavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Resep Favorit'),
      body: Container(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (_, userState) => StreamBuilder(
            stream: ResepServices.getMyResepFavorite(
                (userState as UsersLoaded).user.id),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<Resep> listResep = snapshot.data ?? [];
                return (listResep.isNotEmpty)
                    ? ListView.builder(
                        itemCount: listResep.length,
                        itemBuilder: (_, index) =>
                            CardResepWidget(listResep[index]),
                      )
                    : Center(
                        child: Text(
                          'Tidak terdapat resep',
                          style: blackTextFont,
                        ),
                      );
              } else {
                return Center(
                  child: loading(4),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
