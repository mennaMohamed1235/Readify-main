part of 'author_bloc.dart';

sealed class AuthorState extends Equatable {
  const AuthorState();

  @override
  List<Object> get props => [];
}

final class AuthorInitial extends AuthorState {}

class GetAllAuthorsSuccessState extends AuthorState {
  final List<AuthorEntity> authors;
  const GetAllAuthorsSuccessState({
    required this.authors,
  });
}

final class GetAllAuthorsErrorState extends AuthorState {
  final String errorMessage;

 const GetAllAuthorsErrorState({required this.errorMessage});
}

final class GetAllAuthorsLoadingState extends AuthorState {}
