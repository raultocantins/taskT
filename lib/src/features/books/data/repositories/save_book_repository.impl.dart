import 'package:task_planner/src/features/books/data/datasources/save_book_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/save_book_repository.dart';
import 'package:dartz/dartz.dart';

class SaveBookRepositoryImpl implements SaveBookRepository {
  final SaveBookDatasource _saveTaskDatasource;
  const SaveBookRepositoryImpl(this._saveTaskDatasource);
  @override
  Future<Either<Exception, BookEntity>> call(BookEntity task) async {
    try {
      return Right(BookModel.toEntity(await _saveTaskDatasource(task)));
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
