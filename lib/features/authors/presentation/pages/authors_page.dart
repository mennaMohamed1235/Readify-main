import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/features/authors/presentation/blocs/bloc/author_bloc.dart';
import 'package:fruit_e_commerce/features/authors/presentation/widgets/book_author_widget.dart';
import 'package:fruit_e_commerce/injection_container.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>sl<AuthorBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(
          iconTheme:const IconThemeData(
            color: Colors.white
          ),
              title: Text(
                "Authors",
                style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.bold, fontSize: context.getHight(divide: 0.04), color: Colors.white),
              ),
              centerTitle: true,
            ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => const BookAuthorWidget();
}
