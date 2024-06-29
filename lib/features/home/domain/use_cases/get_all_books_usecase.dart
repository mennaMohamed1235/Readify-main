import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/home/domain/repositories/home_repository.dart';

class GetAllBooksUseCase {
  HomeRepository homeRepository;
  GetAllBooksUseCase({
    required this.homeRepository,
  });
  
   Future<Either<Failure,List<BookEntity>>>call(){
    return homeRepository.getAllBooks();
   }
}
