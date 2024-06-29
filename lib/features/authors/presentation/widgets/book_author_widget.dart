import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/loading_widget.dart';
import 'package:fruit_e_commerce/features/authors/presentation/blocs/bloc/author_bloc.dart';
import 'package:fruit_e_commerce/features/authors/presentation/widgets/book_author_item_widget.dart';

class BookAuthorWidget extends StatefulWidget {
  const BookAuthorWidget({super.key});

  @override
  State<BookAuthorWidget> createState() => _BookAuthorWidgetState();
}

class _BookAuthorWidgetState extends State<BookAuthorWidget> {
  @override
  void initState() {
BlocProvider.of<AuthorBloc>(context).add(GetAllAuthorsEvent());    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.getHight(divide: 0.032), left: context.getWidth(divide: 0.037), right: context.getWidth(divide: 0.037)),
      child: Column(children: [
        //  SearchBarWidget(
        //   onChanged: (query) {

        //   },
        //  ),
        BlocConsumer<AuthorBloc, AuthorState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetAllAuthorsLoadingState) {
              return const LoadingWidget();
            }
            if(state is GetAllAuthorsSuccessState) {
              return Expanded(
                child: Padding(
              padding: EdgeInsets.all(context.getDefaultSize()),
              child: GridView.builder(
                itemCount: 10,
                itemBuilder: (context, index) =>  BookAuthorItemWidget(authorEntity:state.authors[index]),
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(context.getHight(divide: 0.0)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: context.getWidth(divide: 0.05),
                  mainAxisExtent: context.getHight(divide: 0.24),
                ),
              ),
            ));
            }
            else {
              return Center( child: LoadingWidget(),);
            }
          },
        ),
      ]),
    );
  }
}
