part of 'author_bloc.dart';

sealed class AuthorEvent extends Equatable {
  const AuthorEvent();

  @override
  List<Object> get props => [];
}

class GetAllAuthorsEvent extends AuthorEvent{}