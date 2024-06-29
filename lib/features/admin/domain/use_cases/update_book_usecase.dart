import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/admin/domain/repositories/dash_board_repository.dart';

class UpdateBookUseCase {
 final  DashBoardRepository dashBoardRepository;
 const UpdateBookUseCase(this. dashBoardRepository);
  Future<Either<Failure, Unit>> call({required BookEntity bookEntity}){
    return dashBoardRepository.updateBook(bookEntity: bookEntity);
  }
}