// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/presenter/controllers/state_controller.dart';
import 'package:taskt/src/features/home/presenter/widgets/date_bottomsheet.dart';
import 'package:taskt/src/features/home/presenter/widgets/tags_custom_widget.dart';
import 'package:taskt/src/shared/utils/extensions/date_extension.dart';
import '../widgets/card_custom_widget.dart';
import '../widgets/new_task_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> opacityAnimation;
  StateController? _stateController;

  @override
  void initState() {
    super.initState();
    _stateController = GetIt.I.get<StateController>();
    _stateController?.getTask();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    opacityAnimation = CurvedAnimation(
        parent: Tween<double>(begin: 1, end: 0).animate(_animationController),
        curve: Curves.easeInOutExpo);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'My tasks',
                      style: TextStyle(fontSize: 40),
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          barrierColor: Colors.transparent,
                          backgroundColor: Theme.of(context).primaryColor,
                          isDismissible: true,
                          enableDrag: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                          ),
                          context: context,
                          builder: (context) => DateBottomSheet(
                            callback: (newDate) {
                              _stateController?.changeDate(newDate);
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _stateController?.dateFormated ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const TagsCustom(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SizedBox(
                    child: Observer(
                      builder: (context) {
                        return _stateController?.groupByDay.isEmpty ?? false
                            ? Center(
                                child: Lottie.asset(
                                    'assets/animations/empty.json'),
                              )
                            : ListView.builder(
                                itemCount:
                                    _stateController?.groupByDay.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  DateTime? day = _stateController
                                      ?.groupByDay.keys
                                      .elementAt(index);
                                  List<TaskEntity>? items = _stateController
                                      ?.groupByDay.values
                                      .elementAt(index);

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 20,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              day!.formatDateDefault(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: items?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          TaskEntity item = items![i];

                                          return CardCustomWidget(
                                            task: item,
                                            delete: (task) => _stateController
                                                ?.deleteTask(task),
                                            update: (task) => _stateController
                                                ?.updateTask(task),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                barrierColor: Colors.transparent,
                backgroundColor: Theme.of(context).colorScheme.primary,
                isDismissible: true,
                enableDrag: true,
                useSafeArea: false,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const NewTaskBottomSheet(),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
