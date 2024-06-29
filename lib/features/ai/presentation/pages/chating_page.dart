import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/features/ai/presentation/widgets/chatingWidgets/chating_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatingPage extends StatelessWidget {
  const ChatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Chatbot",
            style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.bold, fontSize: context.getHight(divide: 0.04)),
          ),
        ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() =>ChatingWidget();
}
