import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/widgets/authintication_text_form_feild.dart';
import 'package:fruit_e_commerce/features/admin/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController categoryNameController = TextEditingController();
TextEditingController categoryImageController = TextEditingController();

categoryBottomsheet({required BuildContext context, required bool isAdd, String? categoryId}) => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (_) => AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(context.getDefaultSize() * 1.5),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                       isAdd ? "Add New Category" :"Update Category",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(fontSize: context.getDefaultSize() * 2.5, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.getDefaultSize(),
                    ),
                    CustomAuthTextForm(
                        hinttext: "category name",
                        mycontroller: categoryNameController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "category image can't be empty";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: context.getDefaultSize(),
                    ),
                    CustomAuthTextForm(
                        hinttext: "category Image",
                        mycontroller: categoryImageController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "category image can't be empty";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: context.getDefaultSize(),
                    ),
                    BlocConsumer<DashboardBloc, DashboardState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is DashboardLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: context.getHight(divide: 0.06),
                          child: ElevatedButton(
                            onPressed: () {
                              CategoryEntity categoryEntity = CategoryEntity(name: categoryNameController.text, imageUrl: categoryImageController.text, categoryId: isAdd ? "" : categoryId!);
                              if (categoryNameController.text.isNotEmpty && categoryImageController.text.isNotEmpty) {
                                isAdd ? context.read<DashboardBloc>().add(AddCategoryEvent(category: categoryEntity)) : context.read<DashboardBloc>().add(UpdateCategoryEvent(categoryEntity: categoryEntity));
                              } else {
                                Fluttertoast.showToast(msg: "Please fill all the fields", backgroundColor: Colors.amber);
                              }
                            },
                            child: Text(
                              isAdd ? "Add Category" : "Update Category",
                              style: TextStyle(color: Colors.white, fontSize: context.getDefaultSize() * 1.5, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )).whenComplete(() {
      categoryNameController.clear();
      categoryImageController.clear();
    });
