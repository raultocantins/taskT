import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/home/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/home/presenter/controllers/state_controller.dart';
import 'package:task_planner/src/features/home/presenter/utils/enums/priority_enum.dart';
import 'package:task_planner/src/features/home/presenter/utils/enums/recurrence_enum.dart';
import 'package:task_planner/src/features/home/presenter/widgets/tags_custom_widget.dart';
import 'package:task_planner/src/features/home/presenter/utils/enums/tags_enum.dart';
import 'package:task_planner/src/shared/utils/extensions/date_extension.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class NewTaskBottomSheet extends StatefulWidget {
  final bool? edit;
  final TaskEntity? task;
  const NewTaskBottomSheet({this.edit = false, this.task, super.key});

  @override
  State<NewTaskBottomSheet> createState() => _NewTaskBottomSheetState();
}

class _NewTaskBottomSheetState extends State<NewTaskBottomSheet> {
  StateController? _stateController;
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  Priority? _priority;
  Tag? _tag;
  Recurrence? _recurrence;
  DateTime? _dateSelected;
  FocusNode focusNodeTitle = FocusNode();
  FocusNode focusNodeDescription = FocusNode();

  @override
  void initState() {
    _stateController = GetIt.I.get<StateController>();
    setup();
    super.initState();
  }

  void setup() {
    if (widget.edit ?? false) {
      _titleController = TextEditingController(text: widget.task?.title);
      _descriptionController =
          TextEditingController(text: widget.task?.description);
      _priority = widget.task?.priority;
      _tag = widget.task?.tag;
      _recurrence = widget.task?.recurrence;
      _dateSelected = widget.task?.date;
    } else {
      _titleController = TextEditingController(text: '');
      _descriptionController = TextEditingController(text: '');
      _priority = Priority.none;
      _tag = Tag.all;
      _recurrence = Recurrence.none;
      _dateSelected = DateTime.now();
    }
  }

  void updatePriority(Priority priority) {
    setState(() {
      _priority = priority;
    });
  }

  void updateTag(Tag tag) {
    setState(() {
      _tag = tag;
    });
  }

  void updateRecurrence(Recurrence recurrence) {
    setState(() {
      _recurrence = recurrence;
    });
  }

  List<Tag> filterTags(List<Tag> originalList, Tag tagToRemove) {
    List<Tag> updatedList = List.from(originalList);
    updatedList.removeWhere((Tag item) => item == tagToRemove);
    return updatedList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          focusNodeDescription.unfocus();
          focusNodeTitle.unfocus();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                Container(
                  height: 5,
                  width: 30,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: TextSelectionTheme(
                    data: const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    ),
                    child: TextField(
                      controller: _titleController,
                      focusNode: focusNodeTitle,
                      maxLength: 70,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      decoration: InputDecoration(
                        counterStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                        hintText: S.of(context).whattodo,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterTags(TagsCustom.tags, Tag.all).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            _tag == filterTags(TagsCustom.tags, Tag.all)[index]
                                ? updateTag(Tag.all)
                                : updateTag(
                                    filterTags(TagsCustom.tags, Tag.all)[index],
                                  );
                          },
                          child: Builder(
                            builder: (context) {
                              return Chip(
                                backgroundColor: _tag ==
                                        filterTags(
                                            TagsCustom.tags, Tag.all)[index]
                                    ? Colors.white
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.8),
                                elevation: 0.5,
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4),
                                label: Text(
                                  filterTags(TagsCustom.tags, Tag.all)[index]
                                      .label(context),
                                  style: TextStyle(
                                      color: _tag ==
                                              filterTags(TagsCustom.tags,
                                                  Tag.all)[index]
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Divider(
                  height: 4,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).priority,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15)),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
                              side: const BorderSide(color: Colors.white),
                              value: _priority == Priority.high,
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  updatePriority(Priority.high);
                                } else {
                                  updatePriority(Priority.none);
                                }
                              },
                            ),
                            Text(
                              S.of(context).high,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
                              side: const BorderSide(color: Colors.white),
                              value: _priority == Priority.medium,
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  updatePriority(Priority.medium);
                                } else {
                                  updatePriority(Priority.none);
                                }
                              },
                            ),
                            Text(
                              S.of(context).medium,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
                              side: const BorderSide(color: Colors.white),
                              value: _priority == Priority.low,
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  updatePriority(Priority.low);
                                } else {
                                  updatePriority(Priority.none);
                                }
                              },
                            ),
                            Text(
                              S.of(context).low,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
                              side: const BorderSide(color: Colors.white),
                              value: _priority == Priority.none,
                              onChanged: (bool? value) {
                                if (value ?? false) {
                                  updatePriority(Priority.none);
                                } else {
                                  updatePriority(Priority.none);
                                }
                              },
                            ),
                            Text(
                              S.of(context).none,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                const Divider(
                  height: 4,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        picker.DatePicker.showDateTimePicker(context,
                            onChanged: (date) {}, onConfirm: (date) {
                          setState(
                            () {
                              _dateSelected = date;
                            },
                          );
                        },
                            currentTime: _dateSelected,
                            locale: picker.LocaleType.pt);
                      },
                      child: SizedBox(
                        child: Row(
                          children: [
                            const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              (_dateSelected ?? DateTime.now())
                                  .formatDateDefault(context),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.access_time_filled_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              (_dateSelected ?? DateTime.now())
                                  .formatDateToHours(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Divider(
                      height: 4,
                      color: Colors.white,
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 14,
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text('Recurrence',
                //         style: TextStyle(color: Colors.white, fontSize: 15)),
                //     Row(
                //       children: [
                //         Row(
                //           children: [
                //             Checkbox(
                //               shape: const OvalBorder(),
                //               side: const BorderSide(color: Colors.white),
                //               value: _recurrence == Recurrence.daily,
                //               onChanged: (bool? value) {
                //                 if (value ?? false) {
                //                   updateRecurrence(Recurrence.daily);
                //                 } else {
                //                   updateRecurrence(Recurrence.none);
                //                 }
                //               },
                //             ),
                //             const Text(
                //               'Daily',
                //               style:
                //                   TextStyle(color: Colors.white,
                //fontSize: 12),
                //             ),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //               shape: const OvalBorder(),
                //               side: const BorderSide(color: Colors.white),
                //               value: _recurrence == Recurrence.weekly,
                //               onChanged: (bool? value) {
                //                 if (value ?? false) {
                //                   updateRecurrence(Recurrence.weekly);
                //                 } else {
                //                   updateRecurrence(Recurrence.none);
                //                 }
                //               },
                //             ),
                //             const Text(
                //               'Weekly',
                //               style:
                //                   TextStyle(color: Colors.white,
                //fontSize: 12),
                //             ),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //               shape: const OvalBorder(),
                //               side: const BorderSide(color: Colors.white),
                //               value: _recurrence == Recurrence.monthly,
                //               onChanged: (bool? value) {
                //                 if (value ?? false) {
                //                   updateRecurrence(Recurrence.monthly);
                //                 } else {
                //                   updateRecurrence(Recurrence.none);
                //                 }
                //               },
                //             ),
                //             const Text(
                //               'Monthly',
                //               style:
                //                   TextStyle(color: Colors.white,
                // fontSize: 12),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: TextSelectionTheme(
                    data: const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLength: 300,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      decoration: InputDecoration(
                        counterStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        alignLabelWithHint: true,
                        hintText: S.of(context).description,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 24,
                        ),
                      ),
                      focusNode: focusNodeDescription,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        S.of(context).back,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(100, 60),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        if (_titleController?.text.isEmpty ?? false) {
                          focusNodeTitle.requestFocus();
                        } else {
                          if (widget.edit ?? false) {
                            _stateController?.updateTask(
                              TaskEntity(
                                id: widget.task!.id,
                                title: _titleController!.text,
                                description: _descriptionController!.text,
                                priority: _priority!,
                                tag: _tag!,
                                recurrence: _recurrence!,
                                finished: false,
                                date: _dateSelected!,
                                hours: _dateSelected!,
                              ),
                            );
                          } else {
                            _stateController?.createTask(
                              TaskEntity(
                                  title: _titleController!.text,
                                  description: _descriptionController!.text,
                                  priority: _priority!,
                                  tag: _tag!,
                                  recurrence: _recurrence!,
                                  finished: false,
                                  date: _dateSelected!,
                                  hours: _dateSelected!),
                            );
                          }

                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        S.of(context).save,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
