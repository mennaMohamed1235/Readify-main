import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/failures_widget.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/blocs/bloc/favourites_bloc.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/widgets/favourites_item_widget.dart';

class FavouritesPageWidget extends StatelessWidget {
  const FavouritesPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.getHight(divide: 0.032), left: context.getWidth(divide: 0.037), right: context.getWidth(divide: 0.037)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocConsumer<FavouritesBloc, FavouritesState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUserFavouritesLoadingState) {
                return const Expanded(child: Center(child: CircularProgressIndicator()));
              }
              if (state is GetUserFavouritesErrorState) {
                return Expanded(
                  child: Center(
                    child: FaliureWidget(
                      faliureName: state.message,
                      getType: 'favourites',
                    ),
                  ),
                );
              }
              if (state is GetUserFavouritesSuccessState) {
                return Expanded(
                    child: ListView.separated(
                  itemBuilder: (context, index) => FavouritesItemWidget(
                    favouriteBook: state.favouritesBooks[index],
                  ),
                  itemCount: state.favouritesBooks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: context.getHight(divide: 0.02));
                  },
                ));
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
