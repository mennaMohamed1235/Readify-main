part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class GetAllCategoriesLoadingState extends CategoryState {}

final class GetAllCategoriesSuccessState extends CategoryState {
  final List<CategoryEntity> categories;

  const GetAllCategoriesSuccessState({required this.categories});
}

final class GetAllCategoriesFailureState extends CategoryState {
  final String message;

  const GetAllCategoriesFailureState({required this.message});
}

final class GetCategoryBooksLoadingState extends CategoryState {}

final class GetCategoryBooksFailureState extends CategoryState {
  final String message;

  const GetCategoryBooksFailureState({required this.message});
}

final class GetCategoryBooksSuccessState extends CategoryState {
  final List<BookEntity> categoryBooks;

  const GetCategoryBooksSuccessState({required this.categoryBooks});
}
