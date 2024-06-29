part of 'favourites_bloc.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class GetUserFavouritesEvent extends FavouritesEvent {
  final String userId;
  const GetUserFavouritesEvent({required this.userId});
}

class AddBookToFavouritesEvent extends FavouritesEvent {
  final String userId;
  final String bookId;
  const AddBookToFavouritesEvent({
    required this.userId,
    required this.bookId,
  });
   @override
  List<Object> get props => [ userId, bookId];
}

class DeleteBookFromFavouritesEvent extends FavouritesEvent {
  final String userId;
  final String bookId;
  const DeleteBookFromFavouritesEvent({required this.userId, required this.bookId});
    @override
  List<Object> get props => [ userId, bookId];
}
