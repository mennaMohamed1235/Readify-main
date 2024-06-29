import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, List<BookEntity>>> getUserFavourites(String userId);
  Future<Either<Failure,Unit>> addBookToFavourites(String userId, String bookId);
  Future<Either<Failure,Unit>> deleteBookFromFavourites(String userId, String bookId);
}