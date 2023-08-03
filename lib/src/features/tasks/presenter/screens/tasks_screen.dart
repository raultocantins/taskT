// ignore_for_file: unrelated_type_equality_checks, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/presenter/controllers/tasks_controller.dart';
import 'package:task_planner/src/features/tasks/presenter/widgets/date_bottomsheet.dart';
import 'package:task_planner/src/features/tasks/presenter/widgets/tags_custom_widget.dart';
import 'package:task_planner/src/shared/utils/extensions/date_extension.dart';
import '../widgets/card_custom_widget.dart';
import '../widgets/new_task_bottomsheet.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> opacityAnimation;
  TasksController? _controller;
  final PageController _pageController = PageController();

  @override
  void initState() {
    _controller = GetIt.I.get<TasksController>();
    _controller?.getTask();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    opacityAnimation = CurvedAnimation(
        parent: Tween<double>(begin: 1, end: 0).animate(_animationController),
        curve: Curves.easeInOutExpo);

    _pageController.addListener(
      () {
        if (_pageController.page == 0) {
          _controller?.changeDone(false);
        } else {
          _controller?.changeDone(true);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: const [],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).title,
                        style: const TextStyle(fontSize: 40),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
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
                                _controller?.changeDate(newDate);
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
                      _controller?.dateFormated(context) ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const TagsCustom(),
                  Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () {
                          _pageController.jumpToPage(0);
                        },
                        child: Row(
                          children: [
                            Text(
                              S.of(context).undone,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: (_controller?.done ?? false)
                                      ? Colors.grey
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () {
                          _pageController.jumpToPage(1);
                        },
                        child: Text(
                          S.of(context).done,
                          style: TextStyle(
                            fontSize: 16,
                            color: (_controller?.done ?? false)
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          child: Observer(
                            builder: (context) {
                              return _controller?.groupByDay.isEmpty ?? false
                                  ? (_controller?.isLoading ?? false)
                                      ? Container()
                                      : Container()
                                  : ListView.builder(
                                      itemCount:
                                          _controller?.groupByDay.length ?? 0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DateTime? day = _controller
                                            ?.groupByDay.keys
                                            .elementAt(index);
                                        List<TaskEntity>? items = _controller
                                            ?.groupByDay.values
                                            .elementAt(index);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 20,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    day!.formatDateDefault(
                                                        context),
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
                                                  (BuildContext context,
                                                      int i) {
                                                TaskEntity item = items![i];

                                                return CardCustomWidget(
                                                  task: item,
                                                  delete: (task) => _controller
                                                      ?.deleteTask(task),
                                                  update: (task) => _controller
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
                        SizedBox(
                          child: Observer(
                            builder: (context) {
                              return _controller?.groupByDay.isEmpty ?? false
                                  ? (_controller?.isLoading ?? false)
                                      ? Container()
                                      : Container()
                                  : ListView.builder(
                                      itemCount:
                                          _controller?.groupByDay.length ?? 0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DateTime? day = _controller
                                            ?.groupByDay.keys
                                            .elementAt(index);
                                        List<TaskEntity>? items = _controller
                                            ?.groupByDay.values
                                            .elementAt(index);

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height: 20,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    day!.formatDateDefault(
                                                        context),
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
                                                  (BuildContext context,
                                                      int i) {
                                                TaskEntity item = items![i];

                                                return CardCustomWidget(
                                                  task: item,
                                                  delete: (task) => _controller
                                                      ?.deleteTask(task),
                                                  update: (task) => _controller
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                barrierColor: Colors.transparent,
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
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}