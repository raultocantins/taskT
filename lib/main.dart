import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/books/presenter/screens/books_screen.dart';
import 'package:task_planner/src/features/home/presenter/screens/home_screen.dart';
import 'package:task_planner/src/features/signin/presenter/screens/signin_screen.dart';
import 'package:task_planner/src/features/splashScreen/presenter/screens/splash_screen.dart';
import 'package:task_planner/src/features/tasks/presenter/screens/tasks_screen.dart';
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Task planner',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
      routes: {
        '/signin': (context) => const SigninScreen(),
        '/home': (context) => const HomeScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/books': (context) => const BooksScreen(),
      },
    );
  }
}

class NavigatorKey {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
