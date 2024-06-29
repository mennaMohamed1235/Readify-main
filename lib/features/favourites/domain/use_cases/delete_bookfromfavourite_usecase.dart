import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/features/favourites/domain/repositories/favourites_repository.dart';

class DeleteBookFromFavouritesUseCase {
  final FavouritesRepository favouritesRepository;

  const DeleteBookFromFavouritesUseCase({required this.favouritesRepository});

  Future<Either<Failure, Unit>> call({required String userId,required String bookId}) {
    return favouritesRepository.deleteBookFromFavourites(userId, bookId);
  }
}
