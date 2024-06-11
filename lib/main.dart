import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/books/presenter/screens/book_detail_screen.dart';
import 'package:task_planner/src/features/books/presenter/screens/books_screen.dart';
import 'package:task_planner/src/features/home/presentation/screens/home_screen.dart';
import 'package:task_planner/src/features/signin/presentation/screens/signin_screen.dart';
import 'package:task_planner/src/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:task_planner/src/shared/services/database/db.dart';
import 'package:task_planner/src/shared/dependencies/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

late DataBaseCustom dataBaseCustom;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GetItSetup.init();
  if (!kIsWeb) {
    sqfliteFfiInit();
  }
  await GetIt.I.get<DataBaseCustom>().ready;
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0XFF0067FF),
          background: const Color(0XFFF3F3F3),
          primary: const Color(0XFF0067FF),
          secondary: const Color(0XFFDADADA).withOpacity(0.4),
        ),
        useMaterial3: true,
      ),
      home: const SigninScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/book/detail') {
          Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => BookDetailScreen(
              book: args['book'],
            ),
          );
        }
        return null;
      },
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
