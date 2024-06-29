import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/models/book_model.dart';
import 'package:fruit_e_commerce/features/category/data/models/category_model.dart';

abstract class DashBoardRemoteDataSource {
  Future<Unit> addBook({required BookModel bookModel});
  Future<Unit> addCategory({required CategoryModel categoryModel});
  Future<Unit> deleteBook({required String bookId});
  Future<Unit> deleteCategory({required String categoryId});
  Future<Unit> updateCategory({required CategoryModel categoryModel});
  Future<Unit> updateBook({required BookModel bookModel});
}

class DashBoardRemoteDataSourceImpWithDio extends DashBoardRemoteDataSource {
  final Dio dio;
  DashBoardRemoteDataSourceImpWithDio({required this.dio});
  @override
  Future<Unit> addBook({required BookModel bookModel}) async {
    Response response = await dio.post(ApiStrings.addBookEndPoint, data: bookModel.toJson());
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 409) {
      throw DuplicationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addCategory({required CategoryModel categoryModel}) async {
    Response response = await dio.post(ApiStrings.addCategoryEndPoint, data: categoryModel.toJson());
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 409) {
      throw DuplicationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteBook({required String bookId}) async {
    Response response = await dio.delete(ApiStrings.deleteBookEndPoint, data: {'id': bookId});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteCategory({required String categoryId}) async {
    Response response = await dio.delete(ApiStrings.deleteCategoryEndPoint, data: {'id': categoryId});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateCategory({required CategoryModel categoryModel}) async {
    Response response = await dio.put(ApiStrings.updateCategoryEndPoint, data: categoryModel.toJson(), queryParameters: {'categoryId': categoryModel.categoryId});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateBook({required BookModel bookModel}) async {
    Response response = await dio.put(ApiStrings.updateBookEndPoint, data: bookModel.toJson(), queryParameters: {'Id': bookModel.bookId});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
