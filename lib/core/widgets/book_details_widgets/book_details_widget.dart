import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_e_commerce/core/constants/cache_keys.dart';
import 'package:fruit_e_commerce/core/widgets/snack_bar.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/blocs/bloc/favourites_bloc.dart';
import 'package:fruit_e_commerce/features/home/presentation/blocs/bloc/home_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:fruit_e_commerce/core/widgets/book_details_widgets/book_details_image_widget.dart';
import 'package:fruit_e_commerce/core/widgets/book_details_widgets/book_details_types_widget.dart';
import 'package:fruit_e_commerce/core/widgets/custom_eleveted_button.dart';

class BookDetailsWidget extends StatefulWidget {
  final BookEntity book;

  const BookDetailsWidget({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<BookDetailsWidget> createState() => _BookDetailsWidgetState();
}

class _BookDetailsWidgetState extends State<BookDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    var favouritebloc = BlocProvider.of<FavouritesBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is ShareBookSuccessState) {
                Fluttertoast.showToast(msg: "Book shared successfully", backgroundColor: Colors.green);
                Navigator.pop(context);
              }
              if (state is ShareBookFailureState) {
                SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.errorMessage, context);
                Navigator.pop(context);
              }
              if (state is ShareBookLoadingState) {
                AwesomeDialog(context: context, dialogType: DialogType.info, animType: AnimType.bottomSlide, title: 'Please wait', desc: 'preparing for sharing ...', dismissOnBackKeyPress: false, dismissOnTouchOutside: false).show();
              }
            },
            child: IconButton(
                onPressed: () async {
                  BlocProvider.of<HomeBloc>(context).add(ShareBookEvent(book: widget.book));
                },
                icon: const Icon(Icons.share_outlined)),
          ),
          BlocListener<FavouritesBloc, FavouritesState>(
            listener: (context, state) {
              if (state is AddOrDeleteBookFromFavouritesSuccessState) {
                Fluttertoast.showToast(msg: state.successMessage, backgroundColor: Colors.green);
                favouritebloc.add(const GetUserFavouritesEvent(
                  userId: TOKENID_KEY,
                ));
              }
              if (state is AddOrDeleteBookFromFavouritesFailureState) {
                SnackBarMessage.showSnackBar(SnackBarTypes.ERORR, state.message, context);
              }
            },
            child: BlocBuilder<FavouritesBloc, FavouritesState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      _checkIfBookIsFavourite();
                    },
                    icon: favouritebloc.userFavouritesBooks.any((element) => element.bookId == widget.book.bookId)
                        ? const Icon(
                            Icons.favorite,
                            color: AppColors.primaryColor,
                          )
                        : const Icon(Icons.favorite_outline));
              },
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) => SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.all(context.getDefaultSize()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookDetailsImageWidget(
                  bookCover: widget.book.bookCover,
                ),
                SizedBox(
                  width: context.getWidth(divide: 0.9),
                  child: Text(
                    widget.book.title,
                    style: GoogleFonts.nunito().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: context.getDefaultSize() * 2,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${widget.book.author} |${widget.book.publishingDate.year}",
                    style: GoogleFonts.nunito().copyWith(
                      fontSize: context.getDefaultSize() * 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    BookDetailsTypesWidget(),
                    Image.asset(
                      "assets/icons/star_icon.png",
                      height: context.getDefaultSize() * 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: context.getDefaultSize()),
                      child: Text(
                        widget.book.rate.toString().substring(0, 3),
                        style: GoogleFonts.nunito().copyWith(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(context.getDefaultSize() * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomeElevetedButton(
                            text: 'Read Now',
                            bookName: widget.book.title,
                            bookPdfUrl: widget.book.bookPdf,
                          ),
                          SizedBox(
                            height: context.getDefaultSize(),
                          ),
                          //  CustomeElevetedButton(text: 'Read Summary',bookName:book.title,bookPdfUrl: book.bookPdf,),
                        ],
                      ),
                      Column(
                        children: [
                          RatingBar.builder(
                            itemBuilder: (item, index) => const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                              Fluttertoast.showToast(msg: "Rating $rating set for this book", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.primaryColor, textColor: Colors.white, fontSize: context.getDefaultSize() * 1.5);
                            },
                            itemSize: context.getDefaultSize() * 2.5,
                            itemCount: 5,
                            allowHalfRating: true,
                            glowColor: AppColors.primaryColor,
                          ),
                          SizedBox(
                            height: context.getDefaultSize(),
                          ),
                          Text(
                            "Rate this book",
                            style: GoogleFonts.nunito().copyWith(fontSize: context.getDefaultSize() * 1.7, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.subTitleColor,
            thickness: 0.5,
          ),
          Padding(
            padding: EdgeInsets.all(context.getDefaultSize()),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Description :',
                style: GoogleFonts.nunito().copyWith(fontSize: context.getDefaultSize() * 2, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(context.getDefaultSize()),
                child: Text(widget.book.description, style: GoogleFonts.nunito().copyWith(fontSize: context.getDefaultSize() * 1.7, fontWeight: FontWeight.w300)),
              ),
            ]),
          )
        ]),
      );
  _checkIfBookIsFavourite() {
    if (BlocProvider.of<FavouritesBloc>(context).userFavouritesBooks.any((element) => element.bookId == widget.book.bookId)) {
      BlocProvider.of<FavouritesBloc>(context).add(DeleteBookFromFavouritesEvent(
        userId: TOKENID_KEY,
        bookId: widget.book.bookId,
      ));
    } else {
      BlocProvider.of<FavouritesBloc>(context).add(AddBookToFavouritesEvent(
        userId: TOKENID_KEY,
        bookId: widget.book.bookId,
      ));
    }
  }
}
