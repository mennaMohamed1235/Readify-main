import 'package:flutter/material.dart';

import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/book_item_widget.dart';

class BookListWidget extends StatelessWidget {

  final List<BookEntity> books;
  const BookListWidget({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(context.getHight(divide: 0.02)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: context.getHight(divide: 0.03), crossAxisSpacing: context.getWidth(divide: 0.05), mainAxisExtent: context.getHight(divide: 0.28)),
      itemBuilder: (context, index) =>  BookItemWidget(book: books[index],),
      itemCount: books.length,
    );
  }
}
