import 'package:dartz/dartz.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/network/network_info.dart';
import 'package:fruit_e_commerce/features/home/data/data_sources/remote_data_source.dart';
import 'package:fruit_e_commerce/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks() async {
    if (await networkInfo.isConnected) {
      try {
        final List<BookEntity> books = await homeRemoteDataSource.getAllBooks();
        return right(books);
      } on ServerException {
        return left(ServerFailure());
      } on NoDataException {
        return left(NoDataFaliure());
      } catch (e) {

        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }
}
