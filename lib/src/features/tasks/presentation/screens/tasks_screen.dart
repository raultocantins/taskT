// ignore_for_file: unrelated_type_equality_checks, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/home/presentation/controllers/home_controller.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
import 'package:task_planner/src/shared/widgets/date_bottomsheet.dart';
import 'package:task_planner/src/shared/widgets/tags_custom_widget.dart';
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
    GetIt.I.get<HomeController>().getCountTasksPending();
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
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        S.of(context).title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: false,
                            isDismissible: true,
                            enableDrag: true,
                            useSafeArea: true,
                            context: context,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            elevation: 0,
                            builder: (context) => DateBottomSheet(
                              callback: (newDate) {
                                _controller?.changeDate(newDate);
                              },
                              date: _controller?.dateSelected ?? DateTime.now(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Text(
                    'Pendentes e concluídas.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: TagsCustom(
                    onTap: (id) => _controller?.changeTag(id),
                    tagId: _controller?.tagId,
                    tagType: TagType.task,
                    tagRemoved: (id) => _controller?.removeWithTag(id),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
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
                                fontSize: 14,
                                color: (_controller?.done ?? false)
                                    ? Colors.grey
                                    : Colors.black,
                              ),
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
                            fontSize: 14,
                            color: (_controller?.done ?? false)
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
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
                                              SizedBox(
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
                                                    delete: (task) =>
                                                        _controller
                                                            ?.deleteTask(task),
                                                    update: (task) =>
                                                        _controller
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
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
                                              SizedBox(
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
                                                    delete: (task) =>
                                                        _controller
                                                            ?.deleteTask(task),
                                                    update: (task) =>
                                                        _controller
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
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                enableDrag: true,
                useSafeArea: true,
                context: context,
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 0,
                builder: (context) {
                  return const NewTaskBottomSheet();
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
