import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/authors/domain/entities/author_entity.dart';
import 'package:fruit_e_commerce/features/authors/domain/repositories/authors_repository.dart';

class GetAllAuthorsUsecase {
  final AuthorsRepository authorsRepository;

  GetAllAuthorsUsecase(this.authorsRepository);

  Future<Either<Failure,List< AuthorEntity>>> call() {
    return authorsRepository.getAllAuthors();
  }
}
