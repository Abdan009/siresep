part of 'pages.dart';

class SplashScreenMain extends StatefulWidget {
  @override
  _SplashScreenMainState createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.off(
      () => WrapperUser(),
      transition: get2.Transition.zoom,
      duration: Duration(seconds: 1),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - (2 * defaultMargin),
            // padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
