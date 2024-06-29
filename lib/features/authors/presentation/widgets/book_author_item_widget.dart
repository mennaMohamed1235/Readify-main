import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/features/authors/domain/entities/author_entity.dart';

class BookAuthorItemWidget extends StatelessWidget {
  final AuthorEntity authorEntity;
  const BookAuthorItemWidget({
    Key? key,
    required this.authorEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(height: context.getHight(divide: 0.18), width: context.getWidth(divide: 0.4), decoration:  BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(authorEntity.authorImageUrl !=''? authorEntity.authorImageUrl :"https://cdn.vectorstock.com/i/500p/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg" ), fit: BoxFit.cover))),
      Text(authorEntity.authorName, style: TextStyle(fontWeight: FontWeight.w400, fontSize: context.getDefaultSize() * 2)),
    ]);
  }
}
