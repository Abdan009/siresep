part of 'pages.dart';

class WrapperUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firebaseUser = Provider.of<User>(context);
    bool isLogin = false;
    if (firebaseUser != null) {
      context.read<UsersCubit>().getUser(firebaseUser.uid);
      isLogin = true;
    } else {
      isLogin = false;
    }
    return (!isLogin)
        ? LoginPage()
        : BlocBuilder<UsersCubit, UsersState>(
            builder: (_, adminState) {
              if (adminState is UsersLoaded) {
                return HomePage();
              } else {
                return Scaffold(
                  body: Center(
                    child: loading(4.0),
                  ),
                );
              }
            },
          );
  }
}
