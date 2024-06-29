import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/strings/faliures.dart';
import 'package:fruit_e_commerce/core/strings/messages.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/add_book_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/add_category_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/delete_book_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/delete_category_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/update_book_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/update_category_usecase.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/domain/use_cases/get_all_categories_usecase.dart';
import 'package:fruit_e_commerce/features/home/domain/use_cases/get_all_books_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllBooksUseCase getAllBooksUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final AddBookUseCase addBookUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final DeleteBookUseCase deleteBookUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final UpdateBookUseCase updateBookUseCase;
  bool isCategorySelected = true;
  List<CategoryEntity> categories = [];
  DashboardBloc(
    this.getAllBooksUseCase,
    this.getAllCategoriesUseCase,
    this.addBookUseCase,
    this.addCategoryUseCase,
    this.deleteBookUseCase,
    this.deleteCategoryUseCase,
    this.updateCategoryUseCase,
    this.updateBookUseCase
  ) : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      if (event is SwitchCategoryEvent) {
        _changeIsCategorySelected(event.value);
      }
      if (event is GetAllBookDashEvent) {
        emit(GetAllBooksDashLoading());
        final failureOrDashBooks = await getAllBooksUseCase();
        emit(failureOrDashBooks.fold((l) => GetAllBooksDashError(l.toString()), (r) => GetAllBooksDashSuccess(books: r)));
      }
      if (event is GetAllCategoreisDashEvent) {
        emit(GetAllCategoriesDashLoading());
        final failureOrDashCategories = await getAllCategoriesUseCase();
        emit(failureOrDashCategories.fold((l) => GetAllCategoriesDashError(l.toString()), (r) {
          categories = r;
          return GetAllCategoriesDashSuccess(categories: r);
        }));
      }
      if (event is AddBookEvent) {
        emit(DashboardLoadingState());
        final failureOrUnit = await addBookUseCase(bookEntity: event.book);
        emit(_mapEventToState(failureOrUnit, BOOK_ADDED));
      }
      if (event is AddCategoryEvent) {
        emit(DashboardLoadingState());
        final failureOrUnit = await addCategoryUseCase(categoryEntity: event.category);
        emit(_mapEventToState(failureOrUnit, Category_ADDED));
      }
      if (event is DeleteBookEvent) {
        emit(DashboardLoadingState());
        final failureOrUnit = await deleteBookUseCase(bookId: event.bookId);
        emit(_mapEventToState(failureOrUnit, BOOK_DELETED));
      }
      if (event is DeleteCategoryEvent) {
        emit(DashboardLoadingState());
        final failureOrUnit = await deleteCategoryUseCase(categoryId: event.categoryId);
        emit(_mapEventToState(failureOrUnit, Category_DELETED));
      }
      if (event is UpdateCategoryEvent) {
        emit(DashboardLoadingState());
        final failureOrUnit = await updateCategoryUseCase(categoryEntity: event.categoryEntity);
        emit(_mapEventToState(failureOrUnit, Category_UPDATED));
      }

      if(event is UpdateBookEvent){
        emit(DashboardLoadingState());
        final failureOrUnit = await updateBookUseCase(bookEntity: event.bookEntity);
        emit(_mapEventToState(failureOrUnit, BOOK_UPDATED));
      }
    });
  }

  DashboardState _mapEventToState(Either<Failure, Unit> faliureOrUnit, String successMessage) {
    return faliureOrUnit.fold((faliure) => DashboardErrorState(_mapFaliureToMessage(faliure)), (unit) => DashboardSuccessState(successMessage: successMessage));
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
      case DuplicationFailure:
        return DUPLICATION_FAILURE_MESSAGE;

      default:
        return UN_EXCPECTED_ERROR_MESSAGE;
    }
  }

  _changeIsCategorySelected(String value) {
    value == 'Categories' ? add(GetAllCategoreisDashEvent()) : add(GetAllBookDashEvent());
    isCategorySelected = value == 'Categories' ? true : false;
  }
}
