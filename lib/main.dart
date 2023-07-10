import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import 'package:taskt/src/features/home/presenter/screens/home_page.dart';
import 'package:taskt/src/shared/database/db.dart';
import 'package:taskt/src/shared/dependencies/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taskt/src/shared/lifecycle/app_life_cycle.dart';

late DataBaseCustom dataBaseCustom;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateObserver = AppStateObserver();
  WidgetsBinding.instance.addObserver(appStateObserver);
  if (!kIsWeb) {
    sqfliteFfiInit();
  }
  GetItSetup.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task-T',
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.blue),
      home: FutureBuilder(
        future: GetIt.I.get<DataBaseCustom>().ready,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return Scaffold(
              body: Center(
                child: Lottie.asset('assets/animations/splash.json'),
              ),
            );
          }
        },
      ),
    );
  }
}
