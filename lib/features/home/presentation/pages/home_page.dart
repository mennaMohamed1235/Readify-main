import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/constants/cache_keys.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/network/connection/bloc/connection_bloc.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/core/widgets/snack_bar.dart';
import 'package:fruit_e_commerce/features/ai/presentation/pages/ai_search_with_desc.dart';
import 'package:fruit_e_commerce/features/ai/presentation/pages/boarding_robot_page.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:fruit_e_commerce/features/category/presentation/pages/category_page.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/blocs/bloc/favourites_bloc.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/pages/favourites_page.dart';
import 'package:fruit_e_commerce/features/home/presentation/blocs/bloc/home_bloc.dart';
import 'package:fruit_e_commerce/features/home/presentation/widgets/home_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<FavouritesBloc>(context).add(const GetUserFavouritesEvent(userId: TOKENID_KEY));    

    super.initState();
  }

  int currentIndex = 0;
  List<Widget> pages = const [HomePageWidget(), CategoryPage(), FavouritesPage(), AiSearchWithDesc()];
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionBloc, ConnectionStates>(
      listener: (context, state) {
        if (state is ConnectedState) {
          SnackBarMessage.showSnackBar(SnackBarTypes.SUCCESS, state.message, context);
          BlocProvider.of<CategoryBloc>(context).add(GetAllCategoriesEvent());
          BlocProvider.of<HomeBloc>(context).add(GetAllBooksEvent());
          BlocProvider.of<FavouritesBloc>(context).add(const GetUserFavouritesEvent(userId: TOKENID_KEY));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: _buildBody(context),
        bottomNavigationBar: BottomNavigationBar(iconSize: context.getDefaultSize() * 2.5, selectedFontSize: context.getDefaultSize() * 1.4, unselectedFontSize: context.getDefaultSize() * 1.2, currentIndex: currentIndex, type: BottomNavigationBarType.fixed, onTap: (index) => setState(() => currentIndex = index), items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "category"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ai search"),
        ]),
      
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          elevation: 0,
          backgroundColor: Colors.white.withAlpha(0),
          disabledElevation: 0,
          focusElevation: 0,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BoardingRobotWidget()));
          },
          child: Image.asset('assets/icons/chat_bot_icon.png', height: context.getHight(divide: 0.1)),
        ),
      ),
    );
  }

  _buildBody(BuildContext context) => pages[currentIndex];
}
