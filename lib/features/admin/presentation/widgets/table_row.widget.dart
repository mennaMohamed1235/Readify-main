import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/features/admin/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:fruit_e_commerce/features/admin/presentation/widgets/book_bottom_sheet.dart';
import 'package:fruit_e_commerce/features/admin/presentation/widgets/category_bottom_sheet.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';

TableRow tableRow({required BuildContext context, required int index, BookEntity? book, CategoryEntity? categoryEntity, required bool isBook}) => TableRow(
      children: [
        TableCell(
            child: Text(
          '$index',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.getDefaultSize() * 2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
        TableCell(
            child: Text(isBook ? book!.title : categoryEntity!.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.getDefaultSize() * 2,
                ))),
        TableCell(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.getDefaultSize(), vertical: context.getDefaultSize()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (!isBook) {
                    categoryImageController.text = categoryEntity!.imageUrl;
                    categoryNameController.text = categoryEntity.name;
                    categoryBottomsheet(context: context, isAdd: false, categoryId: categoryEntity.categoryId);
                  } else {
                    titleController.text = book!.title;
                    descriptionController.text = book.description;
                    rateController.text = book.rate.toString();
                    numPagesController.text = book.numberOfPages.toString();
                    versionController.text = book.bookVersion.toString();
                    coverController.text = book.bookCover;
                    bookController.text = book.bookPdf;
                    authorController.text = book.author;
                    categoryController.text = context.read<DashboardBloc>().categories.where((element) => element.categoryId == book.categoryId).first.name;
                    booksBottomSheet(context: context, isAdd: false,book: book);
                  }
                },
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.updateButtonColor)),
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.white, fontSize: context.getDefaultSize() * 1.5),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  isBook ? context.read<DashboardBloc>().add(DeleteBookEvent(bookId: book!.bookId)) : context.read<DashboardBloc>().add(DeleteCategoryEvent(categoryId: categoryEntity!.categoryId));
                },
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColors.deleteButtonColor)),
                child: Text('Delete', style: TextStyle(color: Colors.white, fontSize: context.getDefaultSize() * 1.5)),
              ),
            ],
          ),
        )),
      ],
    );
