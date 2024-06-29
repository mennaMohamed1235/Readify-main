import 'package:dartz/dartz.dart';

import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/admin/domain/repositories/dash_board_repository.dart';

class DeleteCategoryUseCase {
 final  DashBoardRepository dashBoardRepository;
  const DeleteCategoryUseCase(
    this.dashBoardRepository,
  );
  Future<Either<Failure, Unit>> call({required String categoryId}) {
    return dashBoardRepository.deleteCategory(categoryId: categoryId);
  }
  
}
