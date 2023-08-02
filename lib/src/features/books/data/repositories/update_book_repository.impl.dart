import 'package:task_planner/src/features/books/data/datasources/update_book_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/update_book_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateBookRepositoryImpl implements UpdateBookRepository {
  final UpdateBookDatasource _updateTaskDatasource;
  const UpdateBookRepositoryImpl(this._updateTaskDatasource);
  @override
  Future<Either<Exception, BookEntity>> call(BookEntity task) async {
    try {
      return Right(BookModel.toEntity(await _updateTaskDatasource(task)));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
