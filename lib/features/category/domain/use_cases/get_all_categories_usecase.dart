import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/domain/repositories/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository categoryRepository;
  GetAllCategoriesUseCase({
    required this.categoryRepository,
  });
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoryRepository.getAllCategories();
  }
}
