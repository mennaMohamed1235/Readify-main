part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllBooksEvent extends HomeEvent{}
class SearchBooksEvent extends HomeEvent {
  final String query;
 const SearchBooksEvent({
    required this.query,
  });
}


class ShareBookEvent extends HomeEvent {
  final BookEntity book;
  const ShareBookEvent({
    required this.book,
  });
}