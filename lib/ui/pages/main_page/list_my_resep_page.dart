part of '../pages.dart';

class MyResepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        'Resep Saya',
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: mainColor,
        onPressed: () {
          Get.to(
            () => UpdateResepPage(),
          );
        },
      ),
      body: Container(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (_, userState) => StreamBuilder(
            stream: ResepServices.getMyResepCollCom(
                (userState as UsersLoaded).user.id),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
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
