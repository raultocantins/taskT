import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/features/tasks/presentation/controllers/tasks_controller.dart';
import 'package:task_planner/src/features/tasks/presentation/utils/enums/tags_enum.dart';

class TagsCustom extends StatefulWidget {
  static final List<Tag> tags = [
    Tag.all,
    Tag.work,
    Tag.personal,
    Tag.birthday,
    Tag.wishlist,
  ];
  const TagsCustom({super.key});

  @override
  State<TagsCustom> createState() => _TagsCustomState();
}

class _TagsCustomState extends State<TagsCustom> {
  TasksController? _stateController;

  @override
  void initState() {
    _stateController = GetIt.I.get<TasksController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: TagsCustom.tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => _stateController?.changeTag(TagsCustom.tags[index]),
              child: Observer(
                builder: (context) {
                  return Chip(
                    labelPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                    side: BorderSide.none,
                    backgroundColor:
                        _stateController?.tag == TagsCustom.tags[index]
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    label: Text(
                      TagsCustom.tags[index].label(context),
                      style: TextStyle(
                        color: _stateController?.tag == TagsCustom.tags[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
