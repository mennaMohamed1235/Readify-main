import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/models/book_model.dart';

abstract class FavouritesRemoteDataSource {
  Future<List<BookModel>> getUserFavourites(String userId);
  Future<Unit> addBookToFavourites(String userId, String bookId);
  Future<Unit> deleteBookFromFavourites(String userId, String bookId);
}

class FavouritesRemoteDataSourceImplWithDio implements FavouritesRemoteDataSource {
  final Dio dio;
  FavouritesRemoteDataSourceImplWithDio({
    required this.dio,
  });
  @override
  Future<List<BookModel>> getUserFavourites(String userId) async {
    Response response = await dio.get("/Favorite/GetMyFavorites", queryParameters: {"userId": userId});
    if (response.statusCode == 200) {
      List responseData = response.data[r"$values"] as List;
      List<BookModel> favouritesBooks = responseData.map((jsonBookModel) => BookModel.fromJson(jsonBookModel)).toList();
      if (favouritesBooks.isEmpty) {
        throw NoDataException();
      }
      return favouritesBooks;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addBookToFavourites(String userId, String bookId) async {
    Response response = await dio.post(ApiStrings.addUserFavoriteEndPoint, data: {
      "userId": userId,
      "bookId": bookId,
    });
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<Unit> deleteBookFromFavourites(String userId, String bookId)async {
   Response response = await dio.delete(ApiStrings.deleteUserFavoriteEndPoint, data: {
      "userId": userId,
      "bookId": bookId,
    });
    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    else {
      throw ServerException();
    }
  }

}
