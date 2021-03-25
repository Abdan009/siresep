import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:siresep/cubit/cubit.dart';
import 'package:siresep/services/services.dart';
import 'package:siresep/ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => UsersCubit())],
      child: StreamProvider.value(
        value: AuthServices.userStream,
        initialData: null,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenMain(),
        ),
      ),
    );
  }
}
