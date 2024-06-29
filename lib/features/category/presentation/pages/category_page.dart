import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:fruit_e_commerce/features/category/presentation/widgets/category_page_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<CategoryBloc>(context).add(GetAllCategoriesEvent());
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Categories",
                style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.bold, fontSize: context.getHight(divide: 0.04), color: Colors.white),
              ),
              centerTitle: true,
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: _buildBody(context)));
  }

  _buildBody(BuildContext context) => const CategoryPageWidget();
}
