import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:taskt/src/features/home/domain/entities/task_entity.dart';
import 'package:taskt/src/features/home/presenter/controllers/state_controller.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/priority_enum.dart';
import 'package:taskt/src/features/home/presenter/widgets/date_bottomsheet.dart';
import 'package:taskt/src/features/home/presenter/widgets/tags_custom_widget.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';

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
  DateTime? _dateSelected;
  double _padding = 0.0;
  final FocusNode _focusNodeDescription = FocusNode();

  @override
  void initState() {
    _stateController = GetIt.I.get<StateController>();
    setup();
    _focusNodeDescription.addListener(() {
      if (_focusNodeDescription.hasFocus) {
        setState(() {
          _padding = MediaQuery.of(context).viewInsets.bottom;
        });
      } else {
        setState(() {
          _padding = 0;
        });
      }
    });
    super.initState();
  }

  setup() {
    if (widget.edit ?? false) {
      _titleController = TextEditingController(text: widget.task?.title);
      _descriptionController =
          TextEditingController(text: widget.task?.description);
      _priority = widget.task?.priority;
      _tag = widget.task?.tag;
      _dateSelected = widget.task?.date;
    } else {
      _titleController = TextEditingController(text: '');
      _descriptionController = TextEditingController(text: '');
      _priority = Priority.none;
      _tag = Tag.all;
      _dateSelected = DateTime.now();
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date.toLocal());
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 30,
                color: Colors.white,
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  autofocus: false,
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  decoration: InputDecoration(
                    counterStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    hintText: 'What do you need to do?',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 24,
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
                  itemCount: TagsCustom.tags.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () => updateTag(TagsCustom.tags[index]),
                        child: Chip(
                          backgroundColor: _tag == TagsCustom.tags[index]
                              ? Colors.white
                              : Colors.blue.withOpacity(0.8),
                          elevation: 0.5,
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          label: Text(
                            TagsCustom.tags[index].label(),
                            style: TextStyle(
                                color: _tag == TagsCustom.tags[index]
                                    ? Colors.blue
                                    : Colors.white),
                          ),
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
                  const Text('Priority',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            shape: const OvalBorder(),
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            value: _priority == Priority.high,
                            onChanged: (bool? value) {
                              if (value ?? false) {
                                updatePriority(Priority.high);
                              } else {
                                updatePriority(Priority.none);
                              }
                            },
                          ),
                          const Text(
                            'High !!!',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            shape: const OvalBorder(),
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            value: _priority == Priority.medium,
                            onChanged: (bool? value) {
                              if (value ?? false) {
                                updatePriority(Priority.medium);
                              } else {
                                updatePriority(Priority.none);
                              }
                            },
                          ),
                          const Text(
                            'Medium !!',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            shape: const OvalBorder(),
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            value: _priority == Priority.low,
                            onChanged: (bool? value) {
                              if (value ?? false) {
                                updatePriority(Priority.low);
                              } else {
                                updatePriority(Priority.none);
                              }
                            },
                          ),
                          const Text(
                            'Low !',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            shape: const OvalBorder(),
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            value: _priority == Priority.none,
                            onChanged: (bool? value) {
                              if (value ?? false) {
                                updatePriority(Priority.none);
                              } else {
                                updatePriority(Priority.none);
                              }
                            },
                          ),
                          const Text(
                            'None',
                            style: TextStyle(color: Colors.white, fontSize: 12),
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
              widget.edit ?? false
                  ? Container()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: Colors.transparent,
                                backgroundColor: Colors.blue,
                                isDismissible: true,
                                enableDrag: true,
                                useSafeArea: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50)),
                                ),
                                context: context,
                                builder: (context) => DateBottomSheet(
                                      callback: (newDate) {
                                        setState(() {
                                          _dateSelected = newDate;
                                        });
                                      },
                                    ));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  formatDate(_dateSelected ?? DateTime.now()),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              )
                            ],
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
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _padding),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: TextField(
                    autofocus: false,
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                      hintText: 'Add your description',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 24,
                      ),
                    ),
                    focusNode: _focusNodeDescription,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Recurring',
                          style: TextStyle(color: Colors.white, fontSize: 14))),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        fixedSize:
                            MaterialStateProperty.all(const Size(100, 60)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      if (widget.edit ?? false) {
                        _stateController?.updateTask(
                          TaskEntity(
                              id: widget.task!.id,
                              title: _titleController!.text,
                              description: _descriptionController!.text,
                              priority: _priority!,
                              tag: _tag!,
                              finished: false,
                              date: _dateSelected!,
                              hours: _dateSelected!),
                        );
                      } else {
                        _stateController?.createTask(
                          TaskEntity(
                              title: _titleController!.text,
                              description: _descriptionController!.text,
                              priority: _priority!,
                              tag: _tag!,
                              finished: false,
                              date: _dateSelected!,
                              hours: _dateSelected!),
                        );
                      }

                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
