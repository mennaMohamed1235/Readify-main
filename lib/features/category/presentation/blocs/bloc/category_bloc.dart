import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/strings/faliures.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/domain/use_cases/get_all_categories_usecase.dart';
import 'package:fruit_e_commerce/features/category/domain/use_cases/get_category_books_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetCategoryBooksUSeCase getCategoryBooksUSeCase;

  late List<CategoryEntity> allCategories;
  late List<BookEntity> allCategoryBooks;

  CategoryBloc(
    this.getAllCategoriesUseCase,
    this.getCategoryBooksUSeCase,
  ) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is GetAllCategoriesEvent || event is RefreshCategoriesEvent) {
        emit(GetAllCategoriesLoadingState());
        final failureOrCategories = await getAllCategoriesUseCase();
        emit(_mapFailureOrCategoriesToState(failureOrCategories));
      }
      if (event is GetCategoryBooksEvent ) {
        emit(GetCategoryBooksLoadingState());
        final failureOrCategoryBooks = await getCategoryBooksUSeCase(event.categoryId);
        failureOrCategoryBooks.fold((failure) => emit(GetCategoryBooksFailureState(message: _mapFaliureToMessage(failure))), (categoryBooks) {
          allCategoryBooks = categoryBooks;
          emit(GetCategoryBooksSuccessState(categoryBooks: allCategoryBooks));
        });
      }
      if (event is SearchCategoryEvent) {
        emit(GetAllCategoriesLoadingState());
        if (event.query.isEmpty) {
          emit(GetAllCategoriesSuccessState(categories: allCategories));
        }
        emit(GetAllCategoriesSuccessState(categories: allCategories.where((category) => category.name.toLowerCase().contains(event.query.toLowerCase())).toList()));
      }
      if (event is SearchCategoryBooksEvent) {
        emit(GetAllCategoriesLoadingState());
        if (event.query.isEmpty) {
          emit(GetCategoryBooksSuccessState(categoryBooks: allCategoryBooks));
        }
        emit(GetCategoryBooksSuccessState(categoryBooks: allCategoryBooks.where((categorybook) => categorybook.title.toLowerCase().contains(event.query.toLowerCase())).toList()));
      }
    });
  }
  CategoryState _mapFailureOrCategoriesToState(Either failureOrCategories) {
    return failureOrCategories.fold((failure) => GetAllCategoriesFailureState(message: _mapFaliureToMessage(failure)), (categories) {
      allCategories = categories;
      return GetAllCategoriesSuccessState(categories: allCategories);
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
