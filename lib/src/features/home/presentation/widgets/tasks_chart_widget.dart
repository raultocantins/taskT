import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/home/presentation/controllers/home_controller.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/priority_enum.dart';

class TasksChart extends StatefulWidget {
  const TasksChart({super.key});

  @override
  State<TasksChart> createState() => _TasksChartState();
}

class _TasksChartState extends State<TasksChart> {
  HomeController? _controller;

  @override
  void initState() {
    _controller = GetIt.I.get<HomeController>();
    _controller?.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tarefas por dia da semana',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta _) {
                                  switch (value.toInt()) {
                                    case 1:
                                      return const Text(
                                        'Seg',
                                      );
                                    case 2:
                                      return const Text(
                                        'Ter',
                                      );
                                    case 3:
                                      return const Text(
                                        'Qua',
                                      );
                                    case 4:
                                      return const Text(
                                        'Qui',
                                      );
                                    case 5:
                                      return const Text(
                                        'Sex',
                                      );
                                    case 6:
                                      return const Text(
                                        'Sáb',
                                      );
                                    case 7:
                                      return const Text(
                                        'Dom',
                                      );
                                    default:
                                      return Container();
                                  }
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 30,
                                showTitles: true,
                              ),
                            ),
                            topTitles: const AxisTitles(),
                            rightTitles: const AxisTitles(),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: const Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 2),
                              left: BorderSide(color: Colors.black12, width: 2),
                              right: BorderSide(color: Colors.black12),
                              top: BorderSide(color: Colors.black12),
                            ),
                          ),
                          barGroups: List.generate(
                            7,
                            (i) => BarChartGroupData(
                              x: i + 1,
                              barsSpace: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: (_controller?.tasks ?? [])
                                      .where(
                                        (task) =>
                                            task.date.weekday == i + 1 &&
                                            (task.priority == Priority.low ||
                                                task.priority == Priority.none),
                                      )
                                      .length
                                      .toDouble(),
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 8,
                                ),
                                BarChartRodData(
                                  toY: (_controller?.tasks ?? [])
                                      .where(
                                        (task) =>
                                            task.date.weekday == i + 1 &&
                                            task.priority == Priority.medium,
                                      )
                                      .length
                                      .toDouble(),
                                  color: Colors.amber,
                                  width: 8,
                                ),
                                BarChartRodData(
                                  toY: (_controller?.tasks ?? [])
                                      .where(
                                        (task) =>
                                            task.date.weekday == i + 1 &&
                                            task.priority == Priority.high,
                                      )
                                      .length
                                      .toDouble(),
                                  color: Colors.red,
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
