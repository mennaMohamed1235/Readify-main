import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/failures_widget.dart';
import 'package:fruit_e_commerce/features/admin/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:fruit_e_commerce/features/admin/presentation/widgets/table_row.widget.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetAllBooksDashLoading || state is GetAllCategoriesDashLoading) {
              return const CircularProgressIndicator();
            }
            if (state is GetAllBooksDashError) {
              return FaliureWidget(
                faliureName: state.errorMessage,
                getType: "",
              );
            }
            if (state is GetAllBooksDashSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(4),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder.all(),
                      children: [
                            TableRow(
                              children: [
                                TableCell(child: Center(child: Text('#', style: TextStyle(fontSize: context.getDefaultSize() * 2.5)))),
                                TableCell(child: Center(child: Text('Name', style: TextStyle(fontSize: context.getDefaultSize() * 2.5)))),
                                TableCell(child: Center(child: Text('Actions', style: TextStyle(fontSize: context.getDefaultSize() * 2.5)))),
                              ],
                            ),
                          ] +
                          List.generate(state.books.length, (index) => tableRow(context: context, index: index, book: state.books[index], isBook: true))),
                ],
              );
            }
            if (state is GetAllCategoriesDashSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(4),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder.all(),
                      children: [
                            TableRow(
                              children: [
                                TableCell(child: Center(child: Text('#', style: TextStyle(fontSize: context.getDefaultSize() * 2.5)))),
                                TableCell(child: Center(child: Text('Name', style: TextStyle(fontSize: context.getDefaultSize() * 2.5)))),
                                TableCell(child: Center(child: Text('Actions', style: TextStyle(fontSize: context.getDefaultSize() * 2.5)))),
                              ],
                            ),
                          ] +
                          List.generate(state.categories.length, (index) => tableRow(context: context, index: index, categoryEntity: state.categories[index], isBook: false))),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
