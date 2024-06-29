import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<BookEntity>>> getAllBooks();
}
