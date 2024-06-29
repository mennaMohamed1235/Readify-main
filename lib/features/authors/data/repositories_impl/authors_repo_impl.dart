import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/network/network_info.dart';
import 'package:fruit_e_commerce/features/authors/data/data_sources/auth_remote_data_source.dart';
import 'package:fruit_e_commerce/features/authors/domain/entities/author_entity.dart';
import 'package:fruit_e_commerce/features/authors/domain/repositories/authors_repository.dart';

class AuthorsRepoImpl extends AuthorsRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;
  AuthorsRepoImpl({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<AuthorEntity>>> getAllAuthors() async {
    if (await networkInfo.isConnected) {
      try {
        final List<AuthorEntity> authors = await authRemoteDataSource.getAllAuthors();
        return right(authors);
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
