part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class GetAllBooksDashLoading extends DashboardState {}

final class GetAllBooksDashSuccess extends DashboardState {
  final List<dynamic> books;

  const GetAllBooksDashSuccess({required this.books});
}

final class GetAllBooksDashError extends DashboardState {
  final String errorMessage;

  const GetAllBooksDashError(this.errorMessage);
}

final class GetAllCategoriesDashLoading extends DashboardState {}

final class GetAllCategoriesDashSuccess extends DashboardState {
  final List<CategoryEntity> categories;

  const GetAllCategoriesDashSuccess({required this.categories});
}

final class GetAllCategoriesDashError extends DashboardState {
  final String errorMessage;

  const GetAllCategoriesDashError(this.errorMessage);
}

final class DashboardErrorState extends DashboardState {
  final String errorMessage;

  const DashboardErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class DashboardSuccessState extends DashboardState {
  final String successMessage;

  const DashboardSuccessState({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

final class DashboardLoadingState extends DashboardState {}

final class BookOrCategoryDeletedSuccessState extends DashboardState {
  final String successMessage;
  const BookOrCategoryDeletedSuccessState({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

final class BookOrCategoryDeletedErrorState extends DashboardState {
  final String errorMessage;
  const BookOrCategoryDeletedErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class BookOrCategoryDeletedLoadingState extends DashboardState {}
