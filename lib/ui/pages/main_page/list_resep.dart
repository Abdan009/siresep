part of '../pages.dart';

class ListResepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Resep'),
      body: Container(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (_, userState) => StreamBuilder(
            stream: ResepServices.getResepCollFavorite(
                (userState as UsersLoaded).user.id),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<Resep> listResep = snapshot.data ?? [];
                return (listResep.isEmpty)
                    ? ListView.builder(
                        itemCount: listResep.length,
                        itemBuilder: (_, index) =>
                            CardResepWidget(listResep[index]))
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
