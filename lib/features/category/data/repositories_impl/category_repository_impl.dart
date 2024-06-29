import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';

import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/network/network_info.dart';
import 'package:fruit_e_commerce/features/category/data/data_sources/category_remote_datasource.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final NetworkInfo networkInfo;
  final CategoryRemoteDataSource categoryRemoteDataSource;
  CategoryRepositoryImpl({
    required this.networkInfo,
    required this.categoryRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final List<CategoryEntity> categories = await categoryRemoteDataSource.getAllCategories();
        return right(categories);
      } on ServerException {
        return left(ServerFailure());
      } on NoDataException {
        return left(NoDataFaliure());
      } catch (error) {
        return left(ServerFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getCategoryBooks(String categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        List<BookEntity> categoryBooks = await categoryRemoteDataSource.getCategoryBooks(categoryId);
        return right(categoryBooks);
      } on ServerException {
        return left(ServerFailure());
      } on NoDataException {
        return left(NoDataFaliure());
      } catch (error) {
        return left(ServerFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }
}
