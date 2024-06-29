import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';

class BookDetailsImageWidget extends StatelessWidget {
  final String bookCover;
  const BookDetailsImageWidget({
    Key? key,
    required this.bookCover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose, alignment: Alignment.center, children: [
      Container(
        color: Colors.white,
      ),
      Container(
        height: context.getHight(divide: 0.3),
        width: context.getWidth(divide: 0.6),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  bookCover,
                ),
                fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: CachedNetworkImage(
              imageUrl: bookCover,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
      )
    ]);
  }
}
