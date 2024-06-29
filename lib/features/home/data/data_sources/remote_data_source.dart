import 'package:dio/dio.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';

import 'package:fruit_e_commerce/core/models/book_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookModel>> getAllBooks();
}

class HomeRemoteDataSourceImplWithDio extends HomeRemoteDataSource {
  Dio dio;
  HomeRemoteDataSourceImplWithDio({
    required this.dio,
  });

  @override
  Future<List<BookModel>> getAllBooks() async {
    Response response = await dio.get(ApiStrings.getAllBooksEndPoint);
    if (response.statusCode == 200) {
      List responseData = response.data[r"$values"] as List;
      List<BookModel> books = responseData.map((jsonBookModel) => BookModel.fromJson(jsonBookModel)).toList();
      print(books);

      if (books.isEmpty) {
        throw NoDataException();
      }
      return books;
    } else {
      throw ServerException();
    }
  }
}
