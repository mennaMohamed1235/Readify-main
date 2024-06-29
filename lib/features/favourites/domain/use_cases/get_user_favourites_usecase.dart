import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/favourites/domain/repositories/favourites_repository.dart';

class GetUserFavouritesUseCase {
  final FavouritesRepository favouritesRepository;
  const GetUserFavouritesUseCase({
   required this.favouritesRepository,
  });
  Future<Either<Failure, List<BookEntity>>> call(String userId){
    return favouritesRepository.getUserFavourites(userId);
  }
}
