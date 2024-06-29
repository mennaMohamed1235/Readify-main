import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/features/ai/data/models/ai_chat_models.dart';
import 'package:fruit_e_commerce/features/ai/presentation/blocs/cubit/ai_cubit.dart';
import 'package:fruit_e_commerce/features/ai/presentation/widgets/chatingWidgets/chat_bubble_widget.dart';
import 'package:fruit_e_commerce/features/ai/presentation/widgets/recommandation_chat_bubble.dart';

class ChatingWidget extends StatelessWidget {
  TextEditingController chatController = TextEditingController();
  ScrollController myScrollController = ScrollController();
  ChatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AiCubit, AiState>(
          builder: (context, state) {
            if (state is ChatUpdatedErrorState) {
              return const Expanded(
                child: Center(
                  child: (Text("something went wrong")),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(), // Ensure scrollability
                controller: myScrollController, // Create a ScrollController

                itemCount: context.read<AiCubit>().chatMessages.length,
                itemBuilder: (context, index) {
                  final message = context.read<AiCubit>().chatMessages[index];
                  switch (message.type) {
                    case MessageType.user:
                      return ChatBubble(message: message.content!, isbotMessage: false);
                    case MessageType.text:
                      return ChatBubble(message: message.content!, isbotMessage: true);
                    case MessageType.recommendation:
                      return RecommandationChatBubble(
                        isbotMessage: true,
                        recommendationMessage: message as BookRecommendation,
                        userMessage: context.read<AiCubit>().chatMessages[index - 1].content!,
                      );
                    default:
                      return Text('Unknown message type');
                  }
                },
              ),
            );
          },
        ),
        chatingTextField(context, chatController, myScrollController),
      ],
    );
  }

  Widget chatingTextField(BuildContext context, TextEditingController chatController, ScrollController scrollController) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(context.getDefaultSize() * 4), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 2.0,
        ),
      ]),
      child: Padding(
        padding: EdgeInsets.all(context.getDefaultSize() * 0.4),
        child: TextField(
          onEditingComplete: () async {
            context.read<AiCubit>().sendChatQuestion(chatController.text);
            FocusScope.of(context).unfocus();
            scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.bounceOut);
          },
          controller: chatController,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'type message here...',
              suffixIcon: InkWell(
                onTap: () async {
                  context.read<AiCubit>().sendChatQuestion(chatController.text);
                  FocusScope.of(context).unfocus();
                  scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                },
                child: Container(
                  padding: EdgeInsets.all(context.getDefaultSize() * 2.5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
                  ),
                  child: Icon(Icons.send, color: Colors.white, size: context.getDefaultSize() * 2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.getDefaultSize() * 4),
                borderSide: const BorderSide(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
