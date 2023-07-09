import 'package:flutter/material.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/priority_enum.dart';

class CardCustomWidget extends StatefulWidget {
  final TaskEntity task;
  final Function(TaskEntity task) delete;

  const CardCustomWidget({required this.task, required this.delete, super.key});

  @override
  State<CardCustomWidget> createState() => _CardCustomWidgetState();
}

class _CardCustomWidgetState extends State<CardCustomWidget> {
  String shortTitle(String text) {
    return text.length > 25
        ? '${widget.task.description.substring(0, 25)}...'
        : text;
  }

  String shortText(String text) {
    return text.length > 95
        ? '${widget.task.description.substring(0, 95)}...'
        : text;
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
          color: widget.task.finished
              ? Colors.green.withOpacity(0.1)
              : widget.task.priority.getColor().withOpacity(0.1),
          elevation: 0,
          borderOnForeground: true,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                style: const TextStyle(fontSize: 18),
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
                                        style: const TextStyle(fontSize: 18),
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
                              style: const TextStyle(fontSize: 13),
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
                                IconButton(
                                  onPressed: () {},
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
                                SizedBox(
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                          activeColor: Colors.green,
                                          shape: const OvalBorder(),
                                          side: const BorderSide(
                                              width: 1, color: Colors.black),
                                          value: widget.task.finished,
                                          onChanged: (value) {},
                                        ),
                                      );
                                    },
                                  ),
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
