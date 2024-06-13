import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:task_planner/src/shared/controllers/tags_controller.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
import 'package:task_planner/src/shared/widgets/create_tag_bottomsheet.dart';

class TagsCustom extends StatefulWidget {
  final int? tagId;
  final TagType tagType;
  final void Function(int? id) onTap;
  final void Function(int id) tagRemoved;
  const TagsCustom({
    super.key,
    required this.tagType,
    required this.onTap,
    required this.tagRemoved,
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
    _controller?.getTags(widget.tagType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SizedBox(
        height: 50,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                _controller?.tags?.length ?? 0,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () => widget.tagId == _controller?.tags?[index].id
                          ? widget.onTap(null)
                          : widget.onTap(_controller?.tags?[index].id),
                      child: Observer(
                        builder: (context) {
                          return Chip(
                            visualDensity: VisualDensity.compact,
                            side: BorderSide.none,
                            backgroundColor:
                                widget.tagId == _controller?.tags?[index].id
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                            elevation: 0,
                            deleteIcon: Icon(
                              Icons.remove_circle_outlined,
                              size: 16,
                              color:
                                  widget.tagId == _controller?.tags?[index].id
                                      ? Colors.white
                                      : null,
                            ),
                            onDeleted: () => _showAlertDialog(context, index),
                            label: Text(
                              _controller?.tags?[index].label ?? '',
                              style: TextStyle(
                                color:
                                    widget.tagId == _controller?.tags?[index].id
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () => {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      enableDrag: true,
                      useSafeArea: true,
                      context: context,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      elevation: 0,
                      builder: (context) {
                        return const CreateTagBottomSheet();
                      },
                    )
                  },
                  child: Chip(
                    labelPadding: const EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                    side: BorderSide.none,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    label: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Adicionar',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              )
            ],
          ),
        ),
      );
    });
  }

  void _showAlertDialog(BuildContext context, int index) {
    HapticFeedback.selectionClick();
    Widget cancelButton = TextButton(
      child: const Text('Cancelar'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
      ),
      child: const Text(
        'Confirmar',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        final id = _controller!.tags![index].id;
        _controller
            ?.deleteTag(_controller!.tags![index].id)
            .then((value) => value ? widget.tagRemoved(id) : null);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        'Remover Tag',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      content: const Text(
        'Você tem certeza de que deseja remover esta tag?',
        style: TextStyle(fontSize: 14),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
