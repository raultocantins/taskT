import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/controllers/tags_controller.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';

class TagsCustom extends StatefulWidget {
  final int? tagId;
  final TagType tagType;
  final void Function(int? id) onTap;
  const TagsCustom({
    super.key,
    required this.tagType,
    required this.onTap,
    this.tagId,
  });

  @override
  State<TagsCustom> createState() => _TagsCustomState();
}

class _TagsCustomState extends State<TagsCustom> {
  TagsController? _controller;

  @override
  void initState() {
    _controller = GetIt.I.get<TagsController>();
    _controller?.getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _controller?.tags?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () => widget.onTap(_controller?.tags?[index].id),
              child: Observer(
                builder: (context) {
                  return Chip(
                    labelPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                    side: BorderSide.none,
                    backgroundColor:
                        widget.tagId == _controller?.tags?[index].id
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    label: Text(
                      _controller?.tags?[index].label ?? '',
                      style: TextStyle(
                        color: widget.tagId == _controller?.tags?[index].id
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
