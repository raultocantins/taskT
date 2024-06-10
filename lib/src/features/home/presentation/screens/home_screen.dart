import 'package:flutter/material.dart';
import 'package:task_planner/src/features/home/presentation/widgets/card_feature_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Welcome, ',
                  children: [
                    TextSpan(
                      text: 'Alex.',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Você possui 5 tarefas para hoje!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1.5),
                  children: const [
                    CardFeature(
                        icon: Icons.task,
                        title: 'Minhas tarefas',
                        subtitle: '5 pendentes',
                        route: '/tasks'),
                    CardFeature(
                        icon: Icons.book,
                        title: 'Meus livros',
                        subtitle: '2 em progresso',
                        route: '/books'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
