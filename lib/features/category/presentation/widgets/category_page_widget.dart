import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/failures_widget.dart';
import 'package:fruit_e_commerce/core/widgets/search_bar_widget.dart';
import 'package:fruit_e_commerce/core/widgets/snack_bar.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:fruit_e_commerce/features/category/presentation/widgets/category_item_widget.dart';

class CategoryPageWidget extends StatefulWidget {
  const CategoryPageWidget({super.key});

  @override
  State<CategoryPageWidget> createState() => _CategoryPageWidgetState();
}

class _CategoryPageWidgetState extends State<CategoryPageWidget> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetAllCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.getHight(divide: 0.032), left: context.getWidth(divide: 0.037), right: context.getWidth(divide: 0.037)),
      child: Column(
        children: [
          SearchBarWidget(
            onChanged: (query) {
              BlocProvider.of<CategoryBloc>(context).add(SearchCategoryEvent(query: query));
            },
          ),
          SizedBox(
            height: context.getHight(divide: 0.02),
          ),
          BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is GetAllCategoriesFailureState) {
                SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.message, context);
              }
            },
            builder: (context, state) {
              if (state is GetAllCategoriesLoadingState) {
                return const Expanded(
                  child:  Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
                );
              }
              if (state is GetAllCategoriesFailureState) {
                return Center(
                  child: FaliureWidget(
                    faliureName: state.message,
                    getType: 'categories',
                  ),
                );
              }
              if (state is GetAllCategoriesSuccessState) {
                return Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: context.getHight(divide: 0.035), crossAxisSpacing: context.getWidth(divide: 0.05), mainAxisExtent: context.getHight(divide: 0.18)),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) => CategoryItemWidget(
                    category: state.categories[index],
                  ),
                ));
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
