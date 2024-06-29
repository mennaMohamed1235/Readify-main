import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';

class CustomRatingWidget extends StatelessWidget {
  final num rating;
  const CustomRatingWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(context.getDefaultSize() * 0.3),
        decoration: BoxDecoration(
          color: AppColors.searchBarColor,
          borderRadius: BorderRadius.circular(context.getHight(divide: 0.01)),
        ),
        child: RatingBarIndicator(
          itemBuilder: (_, i) => const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: context.getHight(divide: 0.017),
          rating: rating.toDouble(),
        ));
  }
}
