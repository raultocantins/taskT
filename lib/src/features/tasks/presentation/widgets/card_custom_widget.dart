import 'package:flutter/material.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/priority_enum.dart';
import 'package:task_planner/src/features/tasks/presentation/widgets/new_task_bottomsheet.dart';

class CardCustomWidget extends StatefulWidget {
  final TaskEntity task;
  final Function(TaskEntity task) delete;
  final Function(TaskEntity task) update;

  const CardCustomWidget(
      {required this.task,
      required this.delete,
      required this.update,
      super.key});

  @override
  State<CardCustomWidget> createState() => _CardCustomWidgetState();
}

class _CardCustomWidgetState extends State<CardCustomWidget> {
  String shortTitle(String text) {
    return text.length > 25 ? '${text.substring(0, 23)}...' : text;
  }

  String shortText(String text) {
    return text.length > 80 ? '${text.substring(0, 80)}...' : text;
  }

  String getTimeDate(DateTime? date) {
    return DateFormat('HH:mm').format(date?.toLocal() ?? DateTime.now());
  }

  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: expanded ? 300 : 85,
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.task.priority.getColor(),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        expanded
                            ? Container()
                            : Text(
                                shortTitle(widget.task.title),
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: widget.task.finished
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            getTimeDate(widget.task.date),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: expanded ? 170 : 20,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            expanded
                                ? Column(
                                    children: [
                                      Text(
                                        widget.task.title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            decoration: widget.task.finished
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            Text(
                              expanded
                                  ? widget.task.description ?? ''
                                  : shortText(widget.task.description ?? ''), //
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: widget.task.finished
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: expanded ? 50 : 0,
                      width: double.infinity,
                      child: expanded
                          ? Row(
                              children: [
                                SizedBox(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Transform.scale(
                                        scale: 1.3,
                                        child: Checkbox(
                                          shape: const OvalBorder(),
                                          side: const BorderSide(),
                                          value: widget.task.finished,
                                          onChanged: (value) {
                                            widget.update(
                                              TaskEntity(
                                                id: widget.task.id,
                                                title: widget.task.title,
                                                description:
                                                    widget.task.description,
                                                priority: widget.task.priority,
                                                finished: value ??
                                                    widget.task.finished,
                                                tagId: widget.task.tagId,
                                                date: widget.task.date,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                widget.task.finished
                                    ? Container()
                                    : IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            enableDrag: true,
                                            useSafeArea: true,
                                            context: context,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            elevation: 0,
                                            builder: (context) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: NewTaskBottomSheet(
                                                  edit: true,
                                                  task: widget.task,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                IconButton(
                                  onPressed: () {
                                    widget.delete(widget.task);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                              ],
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
