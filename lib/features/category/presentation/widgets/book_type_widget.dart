import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';

class BookTypeWidget extends StatelessWidget {
  final String type;
  const BookTypeWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xffE0E0E0), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: context.getDefaultSize() * 2, right: context.getDefaultSize() * 2, top: context.getDefaultSize(), bottom: context.getDefaultSize()),
        child: Text(
          type,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito().copyWith(fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
