import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    'assets/images/login.svg',
                    height: 250,
                  ),
                ),
              ),
              const Align(
                child: Text(
                  'Organize seu trabalho e sua vida, finalmente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 54,
              ),
              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.white,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Continuar com a Apple',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.white,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Continuar com o google',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Ao continuar você estará concordando com ',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'Termos de Uso ',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(text: 'e '),
                    TextSpan(
                      text: 'Política de Privacidade ',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(text: 'do Task Planner.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
