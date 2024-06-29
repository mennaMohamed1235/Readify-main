import 'package:dio/dio.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';

import 'package:fruit_e_commerce/features/authors/data/models/author_model.dart';

abstract class AuthRemoteDataSource {
  Future<List<AuthorModel>> getAllAuthors();
}

class AuthRemoteDataSourceWithDio extends AuthRemoteDataSource {
  Dio dio;
  AuthRemoteDataSourceWithDio({
    required this.dio,
  });
  @override
  Future<List<AuthorModel>> getAllAuthors()async {
   Response response = await dio.get(ApiStrings.getAllAuthors);
    if (response.statusCode == 200) {
      List responseData = response.data[r"$values"] as List;
      List<AuthorModel> authors = responseData.map((jsonBookModel) => AuthorModel.fromJson(jsonBookModel)).toList();
      

      if (authors.isEmpty) {
        throw NoDataException();
      }
      return authors;
    } else {
      throw ServerException();
    }
  }
  }

