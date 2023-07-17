import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/presenter/screens/home_page.dart';
import 'package:task_planner/src/shared/services/database/db.dart';
import 'package:task_planner/src/shared/dependencies/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_planner/src/shared/lifecycle/app_life_cycle.dart';

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
      navigatorKey: NavigatorKey.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Task planner',
      darkTheme: ThemeData.light(),
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.blue),
      home: FutureBuilder(
        future: GetIt.I.get<DataBaseCustom>().ready,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return Scaffold(
              body: Center(
                child: Image.asset(
                  'assets/images/t.png',
                  height: 100,
                  width: 100,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class NavigatorKey {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
