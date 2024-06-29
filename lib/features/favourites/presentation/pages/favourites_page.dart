import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_e_commerce/core/constants/cache_keys.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/snack_bar.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/blocs/bloc/favourites_bloc.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/widgets/favourites_page_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    BlocProvider.of<FavouritesBloc>(context).add(const GetUserFavouritesEvent(userId: TOKENID_KEY));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.bold, fontSize: context.getHight(divide: 0.04), color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => BlocListener<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is AddOrDeleteBookFromFavouritesSuccessState) {
            Fluttertoast.showToast(msg: state.successMessage, backgroundColor: Colors.green);
            BlocProvider.of<FavouritesBloc>(context).add(const GetUserFavouritesEvent(userId: TOKENID_KEY));
          }
          if (state is AddOrDeleteBookFromFavouritesFailureState) {
                SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.message, context);
              }
        },
        child: const FavouritesPageWidget(),
      );
}
