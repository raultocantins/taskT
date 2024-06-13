import 'package:mobx/mobx.dart';
import 'package:task_planner/src/shared/domain/entities/tag_entity.dart';
import 'package:task_planner/src/shared/domain/usecases/create_tag_usecase.dart';
import 'package:task_planner/src/shared/domain/usecases/delete_tag_usecase.dart';
import 'package:task_planner/src/shared/domain/usecases/get_tags_usecase.dart';
import 'package:task_planner/src/shared/utils/enums/tagtype_enum.dart';
part 'tags_controller.g.dart';

// ignore: library_private_types_in_public_api
class TagsController = _TagsControllerBase with _$TagsController;

abstract class _TagsControllerBase with Store {
  final GetTagsUsecase _getTagsUsecase;
  final DeleteTagUsecase _deleteTagUsecase;
  final CreateTagUsecase _createTagUsecase;
  _TagsControllerBase(
      this._getTagsUsecase, this._deleteTagUsecase, this._createTagUsecase);

  @observable
  bool? isLoading = false;

  @observable
  List<TagEntity>? tags = [];

  @action
  void changeTags(List<TagEntity>? value) {
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

  Future<bool> deleteTag(int id) async {
    var result = await _deleteTagUsecase(id);
    return result.fold(
      (l) => false,
      (_) {
        List<TagEntity> updatedList = tags ?? [];
        updatedList.removeWhere((element) => element.id == id);
        changeTags([...updatedList]);
        return true;
      },
    );
  }

  Future<void> saveTag({
    required String label,
    required TagType type,
  }) async {
    var result = await _createTagUsecase(label: label, type: type);
    result.fold(
      (l) => false,
      (r) {
        List<TagEntity> updatedList = tags ?? [];
        updatedList.add(r);
        changeTags([...updatedList]);
      },
    );
  }
}
