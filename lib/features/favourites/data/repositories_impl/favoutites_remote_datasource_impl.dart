import 'package:dartz/dartz.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/network/network_info.dart';
import 'package:fruit_e_commerce/features/favourites/data/data_sources/favourites_remote_datasource.dart';
import 'package:fruit_e_commerce/features/favourites/domain/repositories/favourites_repository.dart';

typedef AddOrDeleteFromFavourites = Future<Unit> Function();

class FavouritesRepositoryImpl implements FavouritesRepository {
  final NetworkInfo networkInfo;
  final FavouritesRemoteDataSource favouritesRemoteDataSource;
  FavouritesRepositoryImpl({
    required this.networkInfo,
    required this.favouritesRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> getUserFavourites(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final List<BookEntity> books = await favouritesRemoteDataSource.getUserFavourites(userId);
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

  @override
  Future<Either<Failure, Unit>> addBookToFavourites(String userId, String bookId) async {
    return _getMessage(() => favouritesRemoteDataSource.addBookToFavourites(userId, bookId));
  }

  @override
  Future<Either<Failure, Unit>> deleteBookFromFavourites(String userId, String bookId) async {
    return _getMessage(() => favouritesRemoteDataSource.deleteBookFromFavourites(userId, bookId));
  }

  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  Future<Either<Failure, Unit>> _getMessage(AddOrDeleteFromFavourites) async {
    if (await networkInfo.isConnected) {
      try {
        return right(await AddOrDeleteFromFavourites());
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }
}
