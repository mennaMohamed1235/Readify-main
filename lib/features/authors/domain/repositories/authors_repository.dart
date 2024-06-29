import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/authors/domain/entities/author_entity.dart';

abstract class AuthorsRepository {
  Future<Either<Failure, List<AuthorEntity>>> getAllAuthors();
}
