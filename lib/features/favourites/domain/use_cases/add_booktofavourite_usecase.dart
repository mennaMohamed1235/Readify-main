import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/features/favourites/domain/repositories/favourites_repository.dart';

import '../../../../core/error/faliure.dart';

class AddBookToFavouriteUseCase {
  FavouritesRepository favouritesRepository;
  AddBookToFavouriteUseCase({
    required this.favouritesRepository,
  });

  Future<Either<Failure, Unit>> call(String userId, String bookId){
    return favouritesRepository.addBookToFavourites(userId, bookId);
  }
}
