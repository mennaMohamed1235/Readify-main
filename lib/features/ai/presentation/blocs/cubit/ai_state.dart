part of 'ai_cubit.dart';

sealed class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

final class AiInitial extends AiState {}

final class ChatUpdatedSuccessState extends AiState {}

final class ChatUpdatedLoadingState extends AiState {}

final class ChatUpdatedErrorState extends AiState {}

final class SearchAiSuccessState extends AiState {
  final List<String> searchResults;

 const SearchAiSuccessState({required this.searchResults});
}

final class SearchAiLoadingState extends AiState {}

final class SearchAiErrorState extends AiState {}
