import 'package:flutter/material.dart';
import 'package:task_planner/src/features/tasks/presenter/utils/enums/tags_enum.dart';
import 'package:task_planner/src/features/tasks/presenter/widgets/date_bottomsheet.dart';
import 'package:task_planner/src/features/tasks/presenter/widgets/tags_custom_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Tag _tag = Tag.all;

  void updateTag(Tag tag) {
    setState(() {
      _tag = tag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Summary\nReport',
                    style: TextStyle(fontSize: 40),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        isDismissible: true,
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                        ),
                        context: context,
                        builder: (context) => DateBottomSheet(
                          callback: (newDate) {
                            // _stateController?.changeDate(newDate);
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
                        onTap: () {
                          _tag == TagsCustom.tags[index]
                              ? updateTag(Tag.all)
                              : updateTag(TagsCustom.tags[index]);
                        },
                        child: Builder(
                          builder: (context) {
                            return Chip(
                              backgroundColor: _tag == TagsCustom.tags[index]
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              elevation: 0.5,
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 4),
                              label: Text(
                                TagsCustom.tags[index].label(context),
                                style: TextStyle(
                                    color: _tag == TagsCustom.tags[index]
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
