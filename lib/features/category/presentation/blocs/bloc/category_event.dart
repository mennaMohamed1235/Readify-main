part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoriesEvent extends CategoryEvent {}

class GetCategoryBooksEvent extends CategoryEvent {
final  String categoryId;
 const GetCategoryBooksEvent({
    required this.categoryId,
  });
}
class SearchCategoryEvent extends CategoryEvent {
  final String query;
  const SearchCategoryEvent({
    required this.query,
  });
}

class SearchCategoryBooksEvent extends CategoryEvent{
  final String query;
  const SearchCategoryBooksEvent({
    required this.query,
  });
}

class RefreshCategoriesEvent extends CategoryEvent{
  
}