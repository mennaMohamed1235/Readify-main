import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String bookId;
  final String title;
  final String author;
  final String description;
  final String bookCover;
  final String bookPdf;
  final num rate;
  final num bookRatingCount;
  final num bookReviewCount;
  final num numberOfPages;
  final String bookVersion;
  final String categoryId;
  final DateTime publishingDate;
  const BookEntity({
    required this.bookId,
    required this.title,
    required this.author,
    required this.description,
    required this.bookCover,
    required this.bookPdf,
    required this.rate,
    required this.bookRatingCount,
    required this.bookReviewCount,
    required this.numberOfPages,
    required this.bookVersion,
    required this.categoryId,
    required this.publishingDate,
  });
  

  

  @override
  List<Object?> get props => [
        bookId,
        title,
        description,
        bookCover,
        bookPdf,
        rate,
        numberOfPages,
        bookVersion,
        categoryId,
        publishingDate,
      ];
}
