import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_e_commerce/core/constants/cache_keys.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/strings/faliures.dart';
import 'package:fruit_e_commerce/core/strings/messages.dart';
import 'package:fruit_e_commerce/features/favourites/domain/use_cases/add_booktofavourite_usecase.dart';
import 'package:fruit_e_commerce/features/favourites/domain/use_cases/delete_bookfromfavourite_usecase.dart';
import 'package:fruit_e_commerce/features/favourites/domain/use_cases/get_user_favourites_usecase.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetUserFavouritesUseCase getUserFavouritesUseCase;
  final AddBookToFavouriteUseCase addBookToFavouriteUseCase;
  final DeleteBookFromFavouritesUseCase deleteBookFromFavouritesUseCase;
  final List<BookEntity> userFavouritesBooks = [];
  FavouritesBloc(
    this.getUserFavouritesUseCase,
    this.addBookToFavouriteUseCase,
    this.deleteBookFromFavouritesUseCase,
  ) : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) async {
      if (event is GetUserFavouritesEvent) {
        userFavouritesBooks.clear();
        emit(GetUserFavouritesLoadingState());
        final failureOrUserFavouritesBooks = await getUserFavouritesUseCase(event.userId);
        emit(_mapFailureOrBooksToState(failureOrUserFavouritesBooks));
      }
      if (event is AddBookToFavouritesEvent) {
        emit(AddOrDeleteBookFromFavouritesLoadingState());
        final failureOrUnit = await addBookToFavouriteUseCase(event.userId, event.bookId);
        emit(
          _mapFailureOrUnitTostate(failureOrUnit: failureOrUnit,successMessage: ADD_FAVOURITE_SUCCESS),
        );
      }
      if (event is DeleteBookFromFavouritesEvent) {
        emit(AddOrDeleteBookFromFavouritesLoadingState());
        final failureOrUnit = await deleteBookFromFavouritesUseCase(userId: event.userId, bookId: event.bookId);
        emit(_mapFailureOrUnitTostate(failureOrUnit: failureOrUnit,successMessage:Remove_FAVOURITE_SUCCESS));
      }
    });
  }

  FavouritesState _mapFailureOrUnitTostate({required Either failureOrUnit,required String successMessage}) {
    return failureOrUnit.fold((failure) => AddOrDeleteBookFromFavouritesFailureState(message: _mapFaliureToMessage(failure)), (unit) =>  AddOrDeleteBookFromFavouritesSuccessState(successMessage: successMessage));
  }

  FavouritesState _mapFailureOrBooksToState(Either failureOrBooks) {
    return failureOrBooks.fold((failure) => GetUserFavouritesErrorState(message: _mapFaliureToMessage(failure)), (books) {
      userFavouritesBooks.addAll(books);
      return GetUserFavouritesSuccessState(favouritesBooks: userFavouritesBooks);
    });
  }

  String _mapFaliureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      // this to get the extended types while run time :)
      case ServerFailure:
        return SERVER_Failure_MESSAGE;

      case ConnectionFailure:
        return OFFLINE_Failure_MESSAGE;

      case NoDataFaliure:
        return EMPTY_CACHE_Failure_MESSAGE;

      default:
        return UN_EXCPECTED_ERROR_MESSAGE;
    }
  }
}
