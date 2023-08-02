import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/services/database/db.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    GetIt.I.get<DataBaseCustom>().ready.then(
          (value) => Navigator.of(context).pushReplacementNamed('/signin'),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
