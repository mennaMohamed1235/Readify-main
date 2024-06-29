import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';

abstract class DashBoardRepository {
  Future<Either<Failure, Unit>> addBook({required BookEntity bookEntity});
  Future<Either<Failure, Unit>> addCategory({required CategoryEntity categoryEntity});
  Future<Either<Failure, Unit>> deleteBook({required String bookId});
  Future<Either<Failure, Unit>> deleteCategory({required String categoryId});
  Future<Either<Failure,Unit>> updateCategory({required CategoryEntity categoryEntity});
  Future<Either<Failure, Unit>> updateBook({required BookEntity bookEntity});
}
