import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/generated/l10n.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:task_planner/src/features/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/priority_enum.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/recurrence_enum.dart';
import 'package:task_planner/src/features/tasks/presentation/widgets/tags_custom_widget.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/tags_enum.dart';
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
  TasksController? _controller;
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
    _controller = GetIt.I.get<TasksController>();
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: TextSelectionTheme(
                  data: const TextSelectionThemeData(),
                  child: TextField(
                    controller: _titleController,
                    focusNode: focusNodeTitle,
                    autofocus: true,
                    maxLength: 70,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: S.of(context).whattodo,
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).tag,
                    style: const TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filterTags(TagsCustom.tags, Tag.all).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              _tag ==
                                      filterTags(
                                          TagsCustom.tags, Tag.all)[index]
                                  ? updateTag(Tag.all)
                                  : updateTag(
                                      filterTags(
                                          TagsCustom.tags, Tag.all)[index],
                                    );
                            },
                            child: Builder(
                              builder: (context) {
                                return Chip(
                                  labelPadding: const EdgeInsets.all(0),
                                  visualDensity: VisualDensity.compact,
                                  side: BorderSide.none,
                                  backgroundColor: _tag ==
                                          filterTags(
                                              TagsCustom.tags, Tag.all)[index]
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.secondary,
                                  elevation: 0,
                                  label: Text(
                                    filterTags(TagsCustom.tags, Tag.all)[index]
                                        .label(context),
                                    style: TextStyle(
                                        color: _tag ==
                                                filterTags(TagsCustom.tags,
                                                    Tag.all)[index]
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 4,
              ),
              const SizedBox(
                height: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).priority,
                      style: const TextStyle(fontSize: 15)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
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
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
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
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
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
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              shape: const OvalBorder(),
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
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    S.of(context).date,
                    style: const TextStyle(fontSize: 15),
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
                            ),
                          ),
                          Text(
                            (_dateSelected ?? DateTime.now())
                                .formatDateDefault(context),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.access_time_filled_outlined,
                            ),
                          ),
                          Text(
                            (_dateSelected ?? DateTime.now())
                                .formatDateToHours(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 4,
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: TextSelectionTheme(
                  data: const TextSelectionThemeData(),
                  child: TextField(
                    controller: _descriptionController,
                    maxLength: 300,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      alignLabelWithHint: true,
                      hintText: S.of(context).description,
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                    ),
                    focusNode: focusNodeDescription,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      S.of(context).back,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      if (_titleController?.text.isEmpty ?? false) {
                        focusNodeTitle.requestFocus();
                      } else {
                        if (widget.edit ?? false) {
                          _controller?.updateTask(
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
                          _controller?.createTask(
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
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
