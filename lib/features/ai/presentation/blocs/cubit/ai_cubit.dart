import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/features/ai/data/models/ai_chat_models.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  Dio dioChat = Dio(BaseOptions(baseUrl: 'https://dc78-41-37-122-24.ngrok-free.app/'));
  Dio dioSearch = Dio(BaseOptions(baseUrl: 'https://5e2d-102-46-168-198.ngrok-free.app/'));

  AiCubit() : super(AiInitial());
  List<Message> chatMessages = [];
  sendChatQuestion(String query) async {
    emit(ChatUpdatedLoadingState());
    chatMessages.add(Message(MessageType.user, query));
    try {
      Response response = await dioChat.get(ApiStrings.aiChatEndPoint + query);
      // final data = response.data as Map<String, dynamic>;
      chatMessages.add(Message.fromJson(response.data));
      emit(ChatUpdatedSuccessState());
    } catch (error) {
      emit(ChatUpdatedErrorState());
    }
  }

  aiSearch(String query) async {
    print(query);
    emit(SearchAiLoadingState());
    try {
      Response response = await dioSearch.post(ApiStrings.aiSearchEndPoint, data: {"description": query});
      List<String> searchResults;
      searchResults =(response.data as List).cast<String>();
      print(searchResults);
      emit(SearchAiSuccessState(searchResults: searchResults));
    } catch (error) {
      emit(SearchAiErrorState());
    }
  }
}
