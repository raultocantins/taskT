import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/controllers/tags_controller.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';

class CreateTagBottomSheet extends StatefulWidget {
  final TagType type;
  const CreateTagBottomSheet({required this.type, super.key});

  @override
  State<CreateTagBottomSheet> createState() => _CreateTagBottomSheetState();
}

class _CreateTagBottomSheetState extends State<CreateTagBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  TagsController? _controller;

  @override
  void initState() {
    _controller = GetIt.I.get<TagsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: TextSelectionTheme(
          data: const TextSelectionThemeData(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: TextField(
              controller: _titleController,
              autofocus: true,
              maxLength: 30,
              onSubmitted: (e) {
                if (e != '') {
                  _controller?.saveTag(label: e, type: widget.type);
                  Navigator.of(context).pop();
                }
              },
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                alignLabelWithHint: true,
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: 'Insira o nome da nova tag',
                hintStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
