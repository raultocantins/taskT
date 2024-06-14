import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/presentation/controllers/home_controller.dart';
import 'package:task_planner/src/features/home/presentation/widgets/card_feature_custom.dart';
import 'package:task_planner/src/features/home/presentation/widgets/tasks_chart_widget.dart';

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
    _controller?.getCountBooksInprogress();
    _controller?.fakeSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => SystemNavigator.pop(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          actions: [
            Observer(builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Row(
                  children: [
                    Text(
                      (_controller?.isLoading ?? false)
                          ? 'Sincronizando os dados'
                          : 'Dados atualizados e sincronizados',
                      style: const TextStyle(fontSize: 12),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        (_controller?.isLoading ?? false)
                            ? Icons.sync
                            : Icons.cloud,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        ),
        body: Observer(builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Bem-vindo, ',
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
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CardFeature(
                              icon: Icons.task,
                              title: 'Minhas tarefas',
                              subtitle: (_controller?.countTasksPending ?? 0) >
                                      0
                                  ? '${_controller?.countTasksPending} ${(_controller?.countTasksPending ?? 0) > 1 ? 'pendentes' : 'pendente'}'
                                  : 'sem tarefas',
                              route: '/tasks'),
                          CardFeature(
                              icon: Icons.book,
                              title: 'Meus livros',
                              subtitle: (_controller?.countBooksInprogress ??
                                          0) >
                                      0
                                  ? '${_controller?.countBooksInprogress} em progresso'
                                  : 'Adicione um livro',
                              route: '/books'),
                          const CardFeature(
                            icon: Icons.timer,
                            title: 'Pomodoro',
                            subtitle: 'Em breve',
                            route: '/',
                            disable: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const TasksChart(),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
