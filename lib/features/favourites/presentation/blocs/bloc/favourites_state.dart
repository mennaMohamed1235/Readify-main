part of 'favourites_bloc.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();
  
  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

class GetUserFavouritesLoadingState extends FavouritesState {}

class GetUserFavouritesSuccessState extends FavouritesState {
  final List<BookEntity> favouritesBooks;
  const GetUserFavouritesSuccessState({required this.favouritesBooks});
  @override
  List<Object> get props => [favouritesBooks];
}

class GetUserFavouritesErrorState extends FavouritesState {
  final String message;
  const GetUserFavouritesErrorState({required this.message,});
  @override
  List<Object> get props => [message];
}

class AddOrDeleteBookFromFavouritesSuccessState extends FavouritesState {
  final String successMessage;
 const AddOrDeleteBookFromFavouritesSuccessState({
    required this.successMessage,
  });
  List<Object> get props => [successMessage];
}

class AddOrDeleteBookFromFavouritesFailureState extends FavouritesState {
  final String message;
  const AddOrDeleteBookFromFavouritesFailureState({required this.message,});
  @override
  List<Object> get props => [message];
}
 class AddOrDeleteBookFromFavouritesLoadingState extends FavouritesState {}
 

 