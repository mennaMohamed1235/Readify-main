import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/strings/faliures.dart';

import 'package:fruit_e_commerce/features/authors/domain/entities/author_entity.dart';
import 'package:fruit_e_commerce/features/authors/domain/use_cases/get_all_authors_usecase.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final GetAllAuthorsUsecase getAllAuthorsUsecase;
  AuthorBloc(
    this.getAllAuthorsUsecase,
  ) : super(AuthorInitial()) {
    on<AuthorEvent>((event, emit) async {
      if (event is GetAllAuthorsEvent) {
        final authorsOrfailure = await getAllAuthorsUsecase();
      emit(  _mapFailureOrAuthorsToState(authorsOrfailure));
      }
    });
  }
}

AuthorState _mapFailureOrAuthorsToState(Either failureOrBooks) {
  return failureOrBooks.fold((failure) => GetAllAuthorsErrorState(errorMessage: _mapFaliureToMessage(failure)), (authors) {
    return GetAllAuthorsSuccessState(authors: authors);
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
