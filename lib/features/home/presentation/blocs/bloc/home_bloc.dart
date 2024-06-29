import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/strings/faliures.dart';
import 'package:fruit_e_commerce/features/home/domain/use_cases/get_all_books_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllBooksUseCase getAllBooksUseCase;
  late List<BookEntity> allBooks;
  HomeBloc(
    this.getAllBooksUseCase,
  ) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetAllBooksEvent) {
        emit(GetAllBooksLoadingState());
        final failureOrBooks = await getAllBooksUseCase();
        emit(_mapFailureOrBooksToState(failureOrBooks));
      }
      if (event is SearchBooksEvent) {
        emit(GetAllBooksLoadingState());
        if (event.query.isEmpty) {
          emit(GetAllBooksSuccessState(books: allBooks));
        }
        emit(GetAllBooksSuccessState(books: allBooks.where((book) => book.title.toLowerCase().contains(event.query.toLowerCase())).toList()));
      }
      if (event is ShareBookEvent) {
        emit(ShareBookLoadingState());
        try{
       await _shareBook(event.book);
        emit(ShareBookSuccessState());
        }catch(e){
          emit(const ShareBookFailureState(errorMessage: "Failed to share book, please try again later"));
        }
      }
    });
  }
  HomeState _mapFailureOrBooksToState(Either failureOrBooks) {
    return failureOrBooks.fold((failure) => GetAllBooksFailiureState(faliureMessage: _mapFaliureToMessage(failure)), (books) {
      allBooks = books;

      return GetAllBooksSuccessState(books: books);
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

  Future<void> _shareBook(BookEntity book) async {
    final url = Uri.parse(book.bookPdf);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final directory = await getTemporaryDirectory();

    final filePath = '${directory.path}/book.pdf';

    File(filePath).writeAsBytesSync(bytes);

    Share.shareFiles(
      [filePath],
      text: " \n Book Name : ${book.title}\n Description : ${book.description} ",
    );
  }
}
