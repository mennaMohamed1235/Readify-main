import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/constants/cache_keys.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/strings/faliures.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/blocs/bloc/favourites_bloc.dart';
import 'package:fruit_e_commerce/features/home/presentation/blocs/bloc/home_bloc.dart';

class FaliureWidget extends StatelessWidget {
  const FaliureWidget({super.key, required this.faliureName, required this.getType, this.categoryId});
  final String faliureName;
  final String getType;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (getType == 'books') {
          BlocProvider.of<HomeBloc>(context).add(GetAllBooksEvent());
        } else if (getType == 'categories') {
          BlocProvider.of<CategoryBloc>(context).add(GetAllCategoriesEvent());
        } else if (getType == 'categoryBooks') {
                    BlocProvider.of<CategoryBloc>(context).add(GetCategoryBooksEvent(categoryId:categoryId! ));
        }
        else if (getType == 'favourites') {
                    BlocProvider.of<FavouritesBloc>(context).add(const GetUserFavouritesEvent(userId:TOKENID_KEY ));
        }
      },
      child: Center(
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Image.asset(
              _mapFaliureToImagePath(faliureName),
              height: context.getHight(divide: 0.5),
              width: double.infinity,
            )),
      ),
    );
  }

  String _mapFaliureToImagePath(String faliureName) {
    switch (faliureName) {
      case OFFLINE_Failure_MESSAGE:
        return "assets/images/no_connection.png";

      case EMPTY_CACHE_Failure_MESSAGE:
        return "assets/images/no_data.png";

      case SERVER_Failure_MESSAGE:
        return "assets/images/server_error.png";

      default:
        return "assets/images/server_error.png";
    }
  }
}
