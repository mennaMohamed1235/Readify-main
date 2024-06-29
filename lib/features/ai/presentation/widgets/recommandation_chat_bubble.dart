import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/features/ai/data/models/ai_chat_models.dart';
import 'package:intl/intl.dart';

class RecommandationChatBubble extends StatelessWidget {
  final bool isbotMessage;
  final BookRecommendation recommendationMessage;
  final String userMessage;
  const RecommandationChatBubble({super.key, required this.isbotMessage, required this.recommendationMessage, required this.userMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isbotMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(context.getDefaultSize()),
        child: Column(
          crossAxisAlignment: isbotMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.getDefaultSize() * 3),
                  bottomLeft: isbotMessage ? Radius.circular(context.getDefaultSize() * 3) : const Radius.circular(0),
                  topRight: Radius.circular(context.getDefaultSize() * 3),
                  bottomRight: !isbotMessage ? Radius.circular(context.getDefaultSize() * 3) : const Radius.circular(0),
                ),
                color: isbotMessage ? AppColors.primaryColor : Colors.white,
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(context.getDefaultSize() * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Certainly! in $userMessage that book has earned a stellar reputation within its category, frequently receiving top ratings and recommendations.",
                      style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.03),
                    ),
                    CachedNetworkImage(
                      imageUrl: recommendationMessage.imageUrl,
                      height: context.getHight(divide: 0.2),
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.01),
                    ),
                    Row(
                      children: [
                        Text(
                          "Book: ",
                          style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600),
                        ),
                        Text(recommendationMessage.author, style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.01),
                    ),
                    Row(
                      children: [Text("Author: ", style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600)), Text(recommendationMessage.author, style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600))],
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.01),
                    ),
                    Row(
                      children: [Text("Feedback: ", style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600)), 
                      
                      Expanded(child: Text(recommendationMessage.feedback, style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600)))],
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.01),
                    ),
                    Row(
                      children: [Text("Rate: ", style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600)), Text("${recommendationMessage.rate}", style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600))],
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.01),
                    ),
                    Row(
                      children: [Text("Published Year: ", style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600)), Text("${recommendationMessage.publishedYear}", style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600))],
                    ),
                    SizedBox(
                      height: context.getHight(divide: 0.03),
                    ),
                    Text(
                      "let me know if you want another book in $userMessage .",
                      style: TextStyle(color: isbotMessage ? Colors.white : Colors.black, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: isbotMessage ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  '${DateFormat.yMEd().add_jms().format(DateTime.now())} ',
                  style: TextStyle(color: Colors.grey, fontSize: context.getHight(divide: 0.015)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
