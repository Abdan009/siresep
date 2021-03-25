part of 'pages.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Login'),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Center(
          child: ListView(
            children: [
              Text('Masuk dengan menggunakan akun Google',
                  style: blackTextFont),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  SignInSignOutResult result =
                      await AuthServices.signInWithGoogle();
                  if (result?.message != null) {
                    flushbar(
                        'Terjadi kesalahan. Harap mencoba kembali', context);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/google.png'),
                          ),
                        ),
                      ),
                      Text(
                        'Login Now',
                        style:
                            blackTextFont.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
