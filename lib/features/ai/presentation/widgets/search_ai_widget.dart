import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';

class SearchAiWidget extends StatelessWidget {
  final String text;
  const SearchAiWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration:const BoxDecoration(
        color: AppColors.searchBarColor,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      height: context.getHight(divide: 0.05),
      width: double.infinity,
      child: Center(
        child: Text(text ,
        textAlign: TextAlign.center,
        style: TextStyle(
          
          fontWeight: FontWeight.bold,
          fontSize: context.getHight(divide: 0.02)
        ),),
      ),
    );
  }
}
