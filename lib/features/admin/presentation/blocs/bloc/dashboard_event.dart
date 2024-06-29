part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}


class GetAllBookDashEvent extends DashboardEvent{

}
class GetAllCategoreisDashEvent extends DashboardEvent{
  
}
class AddBookEvent extends DashboardEvent{
  final BookEntity book;
  const AddBookEvent({required this.book});
}
class AddCategoryEvent extends DashboardEvent{
  final CategoryEntity category;
  const AddCategoryEvent({required this.category});
}
class SwitchCategoryEvent extends DashboardEvent{
 final String value;
const  SwitchCategoryEvent({required this.value});

}
class DeleteBookEvent extends DashboardEvent{
  final String bookId;
  const DeleteBookEvent({required this.bookId});
}
class DeleteCategoryEvent extends DashboardEvent{
  final String categoryId;
  const DeleteCategoryEvent({required this.categoryId});
}
class UpdateCategoryEvent extends DashboardEvent{
  final CategoryEntity categoryEntity;
  const UpdateCategoryEvent({required this.categoryEntity});
}
class UpdateBookEvent extends DashboardEvent{
  final BookEntity bookEntity;
  const UpdateBookEvent({required this.bookEntity});
}