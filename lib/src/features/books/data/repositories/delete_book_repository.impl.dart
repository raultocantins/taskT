import 'package:task_planner/src/features/books/data/datasources/delete_book_datasource.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/delete_book_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteBookRepositoryImpl implements DeleteBookRepository {
  final DeleteBookDatasource _deleteTaskDatasource;
  const DeleteBookRepositoryImpl(this._deleteTaskDatasource);
  @override
  Future<Either<Exception, void>> call(BookEntity task) async {
    try {
      return Right(await _deleteTaskDatasource(task));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
