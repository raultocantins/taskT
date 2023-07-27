import 'package:flutter/material.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';
import 'package:task_planner/src/features/tasks/presenter/utils/enums/priority_enum.dart';
import 'package:task_planner/src/features/tasks/presenter/widgets/new_task_bottomsheet.dart';

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
    return text.length > 25 ? '${text.substring(0, 25)}...' : text;
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
        height: expanded ? 300 : 120,
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
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
                                    fontSize: 18,
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
                            getTimeDate(widget.task.hours),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: expanded ? 170 : 40,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
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
                                  ? widget.task.description
                                  : shortText(widget.task.description), //
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
                      color: Colors.transparent,
                      child: expanded
                          ? Row(
                              children: [
                                SizedBox(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Transform.scale(
                                        scale: 1.5,
                                        child: Checkbox(
                                          activeColor: Colors.green,
                                          shape: const OvalBorder(),
                                          side: const BorderSide(width: 0.5),
                                          value: widget.task.finished,
                                          onChanged: (value) {
                                            widget.update(TaskEntity(
                                                id: widget.task.id,
                                                title: widget.task.title,
                                                description:
                                                    widget.task.description,
                                                priority: widget.task.priority,
                                                finished: value ??
                                                    widget.task.finished,
                                                tag: widget.task.tag,
                                                recurrence:
                                                    widget.task.recurrence,
                                                date: widget.task.date,
                                                hours: widget.task.hours));
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
                                            barrierColor: Colors.transparent,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            isDismissible: true,
                                            enableDrag: true,
                                            useSafeArea: false,
                                            context: context,
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
