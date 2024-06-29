import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';

class CustomAuthTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
   final void Function()? onTap;
  final IconData? suffix;
  final IconData? prefix;
  final VoidCallback? suffixpressed;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  const CustomAuthTextForm({
    Key? key,
    required this.hinttext,
    required this.mycontroller,
    this.validator,
    this.onTap,
    this.suffix,
    this.prefix,
    this.suffixpressed,
    required this.obscureText,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
      onTap:onTap ,
        style: TextStyle(fontSize: context.getHight(divide: 0.02)),
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: validator,
        controller: mycontroller,
        readOnly: readOnly ?? false,

        ///see it again
        decoration: InputDecoration(
          labelText: hinttext,
          prefixIconColor: AppColors.primaryColor,

          // you should put this to mke border fixed when you click on the button
          border: const OutlineInputBorder(),

          hintText: hinttext,
          contentPadding: EdgeInsets.all(context.getHight(divide: 0.02)),
        ),
      ),
    );
  }
}
