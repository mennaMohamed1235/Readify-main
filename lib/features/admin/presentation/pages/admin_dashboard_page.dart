import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/strings/messages.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/features/admin/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:fruit_e_commerce/features/admin/presentation/widgets/book_bottom_sheet.dart';
import 'package:fruit_e_commerce/features/admin/presentation/widgets/category_bottom_sheet.dart';
import 'package:fruit_e_commerce/features/admin/presentation/widgets/table_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  // ignore: prefer_final_fields
  String _value = 'Categories';
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetAllCategoreisDashEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.buttonColor,
        label: Text(
          'Add +',
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: context.getDefaultSize() * 2.5, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          context.read<DashboardBloc>().isCategorySelected ? categoryBottomsheet(context: context, isAdd: true) : booksBottomSheet(context: context, isAdd: true);
        },
      ),
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardSuccessState) {
            Fluttertoast.showToast(msg: state.successMessage, backgroundColor: Colors.green);
            if (state.successMessage == BOOK_ADDED || state.successMessage == Category_ADDED || state.successMessage == Category_UPDATED || state.successMessage == BOOK_UPDATED) {
              Navigator.pop(context);
            }
            context.read<DashboardBloc>().isCategorySelected ? context.read<DashboardBloc>().add(GetAllCategoreisDashEvent()) : context.read<DashboardBloc>().add(GetAllBookDashEvent());
          }
          if (state is DashboardErrorState) {
            Fluttertoast.showToast(msg: state.errorMessage, backgroundColor: Colors.red);

            context.read<DashboardBloc>().isCategorySelected ? context.read<DashboardBloc>().add(GetAllCategoreisDashEvent()) : context.read<DashboardBloc>().add(GetAllBookDashEvent());
          }
        },
        child: const TableWidget(),
      );

  _buildAppBar() => AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          underline: null,
          itemHeight: context.getHight(divide: 0.06),
          iconSize: context.getDefaultSize() * 3,
          value: _value,
          items: <DropdownMenuItem<String>>[
            DropdownMenuItem(
              value: 'Categories',
              child: Text(
                'Categories',
                style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.w200, fontSize: context.getHight(divide: 0.04)),
              ),
            ),
            DropdownMenuItem(
                value: 'Books',
                child: Text(
                  'Books',
                  style: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.w200, fontSize: context.getHight(divide: 0.04)),
                )),
          ],
          onChanged: (String? value) {
            setState(() {
              _value = value!;
              context.read<DashboardBloc>().add(SwitchCategoryEvent(value: _value));
            });
          },
        ),
      ));
}
