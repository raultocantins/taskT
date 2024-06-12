import 'package:mobx/mobx.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/domain/usecases/get_tags_usecase.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
part 'tags_controller.g.dart';

// ignore: library_private_types_in_public_api
class TagsController = _TagsControllerBase with _$TagsController;

abstract class _TagsControllerBase with Store {
  final GetTagsUsecase _getTagsUsecase;
  _TagsControllerBase(
    this._getTagsUsecase,
  );

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

  Future<void> getTags(TagType tagType) async {
    changeIsLoading(true);
    var result = await _getTagsUsecase(tagType);
    result.fold(
      (l) => null,
      (r) {
        changeTags(r);
      },
    );
    changeIsLoading(false);
  }
}
