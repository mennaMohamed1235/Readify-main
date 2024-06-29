import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/admin/domain/repositories/dash_board_repository.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';

class UpdateCategoryUseCase {
  final DashBoardRepository dashBoardRepository;
  UpdateCategoryUseCase({required this.dashBoardRepository});
  Future<Either<Failure, Unit>> call({required CategoryEntity categoryEntity}) {
    return dashBoardRepository.updateCategory(categoryEntity: categoryEntity);
  }
}
