import 'package:dartz/dartz.dart';
import 'package:task_planner/src/shared/domain/repositories/delete_tag_repository.dart';

abstract class DeleteTagUsecase {
  Future<Either<Exception, void>> call(int id);
}

class DeleteTagUsecaseImpl implements DeleteTagUsecase {
  final DeleteTagRepository _deleteTagRepository;
  const DeleteTagUsecaseImpl(this._deleteTagRepository);
  @override
  Future<Either<Exception, void>> call(int id) {
    return _deleteTagRepository(id);
  }
}
