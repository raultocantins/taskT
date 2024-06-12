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
        switch (settings.name) {
          case '/book/detail':
            Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;
            return CustomPageRoute(
                page: BookDetailScreen(
              book: args['book'],
            ));
          case '/signin':
            return CustomPageRoute(page: const SigninScreen());
          case '/home':
            return CustomPageRoute(page: const HomeScreen());
          case '/tasks':
            return CustomPageRoute(page: const TasksScreen());
          case '/books':
            return CustomPageRoute(page: const BooksScreen());
          default:
            return CustomPageRoute(page: Container());
        }
      },
    );
  }
}

class NavigatorKey {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  CustomPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final bool isPushing =
                secondaryAnimation.status == AnimationStatus.reverse;
            var begin =
                !isPushing ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
                position: animation.drive(tween), child: child);
          },
        );
}
