import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/features/category/presentation/widgets/book_type_widget.dart';

class BookDetailsTypesWidget extends StatelessWidget {
  BookDetailsTypesWidget({super.key});
  final List<String> types = [
    "italian",
    'Horror',
    'romantic',
    'sci fi',
    'adventure',
    'action',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Wrap(
            children: types.map((e) {
          return Padding(
            padding: EdgeInsets.all(context.getDefaultSize() * 0.4), //check
            child: BookTypeWidget(type: e),
          );
        }).toList()),
      ),
    );
  }
}
