import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:taskt/src/features/home/presenter/controllers/state_controller.dart';
import 'package:taskt/src/features/home/presenter/utils/enums/tags_enum.dart';

class TagsCustom extends StatefulWidget {
  static final List<Tag> tags = [
    Tag.all,
    Tag.birthday,
    Tag.personal,
    Tag.wishlist,
    Tag.work
  ];
  const TagsCustom({super.key});

  @override
  State<TagsCustom> createState() => _TagsCustomState();
}

class _TagsCustomState extends State<TagsCustom> {
  StateController? _stateController;

  @override
  void initState() {
    _stateController = GetIt.I.get<StateController>();
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
              onTap: (_stateController?.isLoading ?? false)
                  ? () {}
                  : () => _stateController?.changeTag(TagsCustom.tags[index]),
              child: Observer(
                builder: (context) {
                  return Chip(
                    backgroundColor:
                        _stateController?.tag == TagsCustom.tags[index]
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                    elevation: 0.5,
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    label: Text(
                      TagsCustom.tags[index].label(),
                      style: TextStyle(
                          color: _stateController?.tag == TagsCustom.tags[index]
                              ? Colors.white
                              : null),
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
