import 'package:task_planner/src/features/books/data/datasources/get_books_datasource.dart';
import 'package:task_planner/src/features/books/data/models/book_model.dart';
import 'package:task_planner/src/features/books/domain/entities/book_entity.dart';
import 'package:task_planner/src/features/books/domain/repositories/get_books_repository.dart';
import 'package:dartz/dartz.dart';

class GetBooksRepositoryImpl implements GetBooksRepository {
  final GetBooksDatasource _getTasksDatasource;
  const GetBooksRepositoryImpl(this._getTasksDatasource);
  @override
  Future<Either<Exception, List<BookEntity>>> call(
      {int? tagId, bool? done}) async {
    try {
      List<BookModel> result =
          await _getTasksDatasource(tagId: tagId, done: done);
      return Right(result.map((e) => BookModel.toEntity(e)).toList());
    } catch (error) {
      return Left(error as Exception);
    }
  }
}
