import 'package:mobx/mobx.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/domain/usecases/get_tags_usecase.dart';
part 'tags_controller.g.dart';

// ignore: library_private_types_in_public_api
class TagsController = _TagsControllerBase with _$TagsController;

abstract class _TagsControllerBase with Store {
  final GetTagsUsecase _getTagsUsecase;
  _TagsControllerBase(
    this._getTagsUsecase,
  );

  TagType? type = TagType.task;

  @observable
  bool? isLoading = false;

  @observable
  List<TagEntity>? tags = [];

  @action
  void changeTags(List<TagEntity> value) {
    tags = value;
  }

  @action
  void changeIsLoading(bool value) {
    isLoading = value;
  }

  Future<void> getTask() async {
    changeIsLoading(true);
    var result = await _getTagsUsecase(type);
    result.fold(
      (l) => null,
      (r) {
        changeTags(r);
      },
    );
    changeIsLoading(false);
  }

  void dispose() {
    tags = null;
  }
}
