import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:taskt/src/features/home/presenter/controllers/state_controller.dart';
import 'package:taskt/src/features/home/presenter/widgets/date_bottomsheet.dart';
import 'package:taskt/src/features/home/presenter/widgets/tags_custom_widget.dart';
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
  int i = 0;
  DraggableScrollableController dragController =
      DraggableScrollableController();
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

  bool open = false;
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: (_stateController?.tasks.isEmpty ?? false)
                              ? Center(
                                  child: Lottie.asset(
                                      'assets/animations/empty.json'),
                                )
                              : ListView.builder(
                                  itemCount:
                                      _stateController?.tasks.length ?? 0,
                                  itemBuilder: (context, i) {
                                    return CardCustomWidget(
                                      task: _stateController!.tasks[i],
                                      delete: (task) =>
                                          _stateController?.deleteTask(task),
                                      update: (task) =>
                                          _stateController?.updateTask(task),
                                    );
                                  },
                                ),
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                context: context,
                builder: (context) {
                  return const NewTaskBottomSheet();
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
