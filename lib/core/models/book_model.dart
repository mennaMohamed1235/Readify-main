import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/utils/helper.dart';

class BookModel extends BookEntity {
  const BookModel({required super.bookId, required super.title, required super.description, required super.bookCover, required super.bookPdf, required super.rate, required super.numberOfPages, required super.bookVersion, required super.categoryId, required super.publishingDate, required super.author, required super.bookRatingCount, required super.bookReviewCount});
 factory  BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        bookId: json['id'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        bookCover: json['coverUrl'] ?? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%2Fimages%3Fk%3Dno%2Bimage%2Bavailable&psig=AOvVaw1aEgeBV299sC49uDmA1N9V&ust=1715163444467000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJijsfGn-4UDFQAAAAAdAAAAABAE",
        bookPdf: json['bookUrl'] ?? "",
        rate: json['rate'] ?? 0.0,
        numberOfPages: json['no_Pages'] ?? 0,
        bookVersion: json['version'] ?? "",
        categoryId: json['categoryId'] ?? "",
        author: json['authorName'] ?? "",
        publishingDate: DateTime.parse(json['publishing_date'] ?? "1960-11-07T00:00:00"),
        bookRatingCount: json['book_Rating_Count'] ?? 0,
        bookReviewCount: json['book_Review_Count'] ?? 0);
  }

  Map<String, dynamic> toJson() => {'title': title, 'description': description, 'coverUrl': Helper.generateDownloadLink(bookCover), 'authorName': author, 'bookUrl':Helper.generateDownloadLink(bookPdf), 'rate': rate, 'no_Pages': numberOfPages, 'version': bookVersion, 'categoryId': categoryId, 'publishing_date': publishingDate.toIso8601String()};
}
