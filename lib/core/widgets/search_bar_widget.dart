


import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  Function(String )? onChanged;

  SearchBarWidget({
    Key? key,
    this.onChanged,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      textStyle: MaterialStatePropertyAll(TextStyle(fontSize: context.getDefaultSize() * 2)),
      leading: Padding(
        padding: EdgeInsets.only(right: context.getWidth(divide: 0.009)),
        child: Icon(
          Icons.search,
          color: Colors.black,
          size: context.getDefaultSize() * 2.5,
        ),
      ),
      hintText: "Search",
      hintStyle:  MaterialStatePropertyAll(TextStyle(color: AppColors.subTitleColor,fontSize: context.getDefaultSize()*2)),
      elevation: const MaterialStatePropertyAll(0),
      padding: MaterialStatePropertyAll(EdgeInsets.all(context.getHight(divide: 0.013))),
      backgroundColor: const MaterialStatePropertyAll(AppColors.backgroundColor),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(context.getHight(divide: 0.01))))),
      onChanged: onChanged!, 
    );
  }
}
