import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/core/widgets/app_drawer.dart';
import 'package:fruit_e_commerce/core/widgets/book_list_widget.dart';
import 'package:fruit_e_commerce/core/widgets/failures_widget.dart';
import 'package:fruit_e_commerce/core/widgets/snack_bar.dart';
import 'package:fruit_e_commerce/features/home/presentation/blocs/bloc/home_bloc.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
   @override
  void initState() {
    
    super.initState();
      BlocProvider.of<HomeBloc>(context).add(GetAllBooksEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulildAppBar(context),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context).add(GetAllBooksEvent());
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is GetAllBooksFailiureState) {
              SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.faliureMessage, context);
            }
          },
          builder: (context, state) {
          
            if (state is GetAllBooksLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetAllBooksFailiureState) {
              return FaliureWidget(faliureName: state.faliureMessage,getType: "books",);
            }
            if (state is GetAllBooksSuccessState) {
              return BookListWidget(
                books: state.books,
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  _bulildAppBar(BuildContext context) => AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                'assets/icons/drawer_icon.png',
                height: context.getDefaultSize() * 5,
                width: context.getWidth(divide: 0.1),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: SearchBar(
          textStyle: MaterialStatePropertyAll(TextStyle(fontSize: context.getDefaultSize() * 1.5)),
          shadowColor: const MaterialStatePropertyAll(Colors.white),
          elevation: const MaterialStatePropertyAll(0),
          constraints: BoxConstraints(minWidth: context.getWidth(divide: 0.7), minHeight: context.getHight(divide: 0.06)),
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          hintStyle: const MaterialStatePropertyAll(TextStyle(color: AppColors.subTitleColor)),
          onChanged: (value) {
            BlocProvider.of<HomeBloc>(context).add(SearchBooksEvent(query: value));
          },
          leading: Icon(
            Icons.search,
            color: AppColors.subTitleColor,
            size: context.getDefaultSize() * 2,
          ),
          hintText: "Search book/title/author",
        ),
      );
}
