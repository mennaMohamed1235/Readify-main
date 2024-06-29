import 'package:dio/dio.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/models/book_model.dart';

import 'package:fruit_e_commerce/features/category/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<List<BookModel>> getCategoryBooks(String categoryId);
}

class CategoryRemoteDataSourceImplWithDio extends CategoryRemoteDataSource {
  Dio dio;
  CategoryRemoteDataSourceImplWithDio({
    required this.dio,
  });
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final Response response = await dio.get(ApiStrings.getAllCategoriesEndPoint);
    List<CategoryModel> categories;
    if (response.statusCode == 200) {
      List responseData = response.data[r"$values"] as List;
      categories = responseData.map((jsonCategoryModel) => CategoryModel.fromJson(jsonCategoryModel)).toList();
      if (categories.isEmpty) {
        throw NoDataException();
      }
      return categories;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<BookModel>> getCategoryBooks(String categoryId) async {
    final Response response = await dio.get(
      "/Categories/$categoryId/books",
    );

    List<BookModel> categoryBooks;
    if (response.statusCode == 200) {
      List responseData = response.data[r"$values"] as List;
      categoryBooks = responseData.map((categoryBooksJsonModel) => BookModel.fromJson(categoryBooksJsonModel)).toList();
      if (categoryBooks.isEmpty) {
        throw NoDataException();
      }
      return categoryBooks;
    } else {
      throw ServerException();
    }
  }
}
