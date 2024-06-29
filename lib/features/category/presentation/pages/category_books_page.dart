import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/book_list_widget.dart';
import 'package:fruit_e_commerce/core/widgets/failures_widget.dart';
import 'package:fruit_e_commerce/core/widgets/search_bar_widget.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';

class CategoryBooksPage extends StatefulWidget {
  final CategoryEntity category;
  const CategoryBooksPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryBooksPage> createState() => _CategoryBooksPageState();
}

class _CategoryBooksPageState extends State<CategoryBooksPage> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryBooksEvent(categoryId: widget.category.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<CategoryBloc>(context).add(RefreshCategoriesEvent());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        title: Text(
          widget.category.name,
          style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.bold, fontSize: context.getHight(divide: 0.04)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: context.getHight(divide: 0.032), left: context.getWidth(divide: 0.037), right: context.getWidth(divide: 0.037)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchBarWidget(
              onChanged: (query) {
                BlocProvider.of<CategoryBloc>(context).add(SearchCategoryBooksEvent(query: query));
              },
            ),
            SizedBox(
              height: context.getHight(divide: 0.02),
            ),
            BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetCategoryBooksLoadingState) {
                  return const Expanded(
                    child: Align(alignment: Alignment.center, child: CircularProgressIndicator()),
                  );
                }
                if (state is GetCategoryBooksFailureState) {
                  return Center(
                      child: FaliureWidget(
                    faliureName: state.message,
                    getType: "categoryBooks",
                    categoryId: widget.category.categoryId,
                  ));
                }
                if (state is GetCategoryBooksSuccessState) {
                  return Expanded(
                      child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<CategoryBloc>(context).add(GetCategoryBooksEvent(categoryId: widget.category.categoryId));
                    },
                    child: BookListWidget(
                      books: state.categoryBooks,
                    ),
                  ));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
