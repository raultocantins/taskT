import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/presentation/controllers/home_controller.dart';
import 'package:task_planner/src/features/home/presentation/widgets/card_feature_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController? _controller;

  @override
  void initState() {
    _controller = GetIt.I.get<HomeController>();
    _controller?.getCountTasksPending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                Observer(builder: (
                  context,
                ) {
                  return Text(
                    (_controller?.countTasksPending ?? 0) > 0
                        ? 'Você possui ${_controller?.countTasksPending} ${(_controller?.countTasksPending ?? 0) > 1 ? 'tarefas pendentes' : 'tarefa pendente'}!.'
                        : 'Você não possui nenhuma tarefa pendente.',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  );
                }),
                const SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: Observer(builder: (context) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1.5),
                      children: [
                        CardFeature(
                            icon: Icons.task,
                            title: 'Minhas tarefas',
                            subtitle: (_controller?.countTasksPending ?? 0) > 0
                                ? '${_controller?.countTasksPending} ${(_controller?.countTasksPending ?? 0) > 1 ? 'pendentes' : 'pendente'}'
                                : 'sem tarefas',
                            route: '/tasks'),
                        const CardFeature(
                            icon: Icons.book,
                            title: 'Meus livros',
                            subtitle: '2 em progresso',
                            route: '/books'),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
