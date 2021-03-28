part of '../pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabs(),
    );
  }

  Widget tabs() {
    final tabs = [
      ListResepPage(),
      MyFavoritePage(),
      MyResepPage(),
      ProfilePage()
    ];
    return tabs[currentIndex];
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: mainColor,
      unselectedItemColor: Color(0xFFE5E5E5),
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      //iconSize: 20,
      onTap: (index) {
        setState(
          () {
            currentIndex = index;
          },
        );
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Resep'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Resep Saya'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
