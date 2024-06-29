import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/presentation/pages/category_books_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    Key? key,
    required this.category,
  }) : super(key: key);
  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategoryBooksPage(
                      category: category,
                    )));
      },
      child: Stack(children: [
        Container(
          height: context.getHight(divide: 0.18),
          width: context.getWidth(divide: 0.46),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(context.getHight(divide: 0.01))),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    category.imageUrl,
                  ),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: context.getHight(divide: 0.18),
          width: context.getWidth(divide: 0.46),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(context.getHight(divide: 0.01))),
            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [Colors.black, Colors.black.withOpacity(0.3)],
            ),
          ),
          child: Center(
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans().copyWith(
                color: Colors.white,
                fontSize: context.getHight(divide: 0.03),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
