import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/category/domain/repositories/category_repository.dart';

class GetCategoryBooksUSeCase {
  final CategoryRepository categoryRepository;
  const GetCategoryBooksUSeCase({
    required this.categoryRepository,
  });

  Future<Either<Failure, List<BookEntity>>> call(String categoryId) {
    return categoryRepository.getCategoryBooks(categoryId);
  }
}
