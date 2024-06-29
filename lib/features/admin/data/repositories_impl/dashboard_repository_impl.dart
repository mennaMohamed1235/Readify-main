import 'package:dartz/dartz.dart';
import 'package:fruit_e_commerce/core/entities/book_entity.dart';
import 'package:fruit_e_commerce/core/error/exeptions.dart';
import 'package:fruit_e_commerce/core/error/faliure.dart';
import 'package:fruit_e_commerce/core/models/book_model.dart';
import 'package:fruit_e_commerce/core/network/network_info.dart';
import 'package:fruit_e_commerce/features/admin/data/data_sources/dashboard_remote_datasource.dart';
import 'package:fruit_e_commerce/features/admin/domain/repositories/dash_board_repository.dart';
import 'package:fruit_e_commerce/features/category/data/models/category_model.dart';
import 'package:fruit_e_commerce/features/category/domain/entities/category_entity.dart';

class DashBoardRepositoryImpl extends DashBoardRepository {
  final NetworkInfo networkInfo;
  final DashBoardRemoteDataSource dashBoardRemoteDataSource;

  DashBoardRepositoryImpl(this.networkInfo, this.dashBoardRemoteDataSource);
  @override
  Future<Either<Failure, Unit>> addBook({required BookEntity bookEntity}) async {
    BookModel bookModel = BookModel(bookId: bookEntity.bookId, title: bookEntity.title, description: bookEntity.description, bookCover: bookEntity.bookCover, bookPdf: bookEntity.bookPdf, rate: bookEntity.rate, numberOfPages: bookEntity.numberOfPages, bookVersion: bookEntity.bookVersion, categoryId: bookEntity.categoryId, publishingDate: bookEntity.publishingDate, author: bookEntity.author, bookRatingCount: bookEntity.bookRatingCount, bookReviewCount: bookEntity.bookReviewCount);
    if (await networkInfo.isConnected) {
      try {
        await dashBoardRemoteDataSource.addBook(bookModel: bookModel);
        return right(unit);
      } on DuplicationException {
        return left(DuplicationFailure());
      } on ServerException {
        return left(ServerFailure());
      } catch (error) {
        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addCategory({required CategoryEntity categoryEntity}) async {
    CategoryModel categoryModel = CategoryModel(categoryId: categoryEntity.categoryId, name: categoryEntity.name, imageUrl: categoryEntity.imageUrl);
    if (await networkInfo.isConnected) {
      try {
        await dashBoardRemoteDataSource.addCategory(categoryModel: categoryModel);
        return right(unit);
      } on DuplicationException {
        return left(DuplicationFailure());
      } on ServerException {
        return left(ServerFailure());
      } catch (error) {
        print("omarrrrrrrrrrrrrrrrrrrrrrrr******************************");
        print(error.toString());
        print("omarrrrrrrrrrrrrrrrrrrrrrrr******************************");

        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBook({required String bookId}) async {
    if (await networkInfo.isConnected) {
      try {
        await dashBoardRemoteDataSource.deleteBook(bookId: bookId);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      } catch (error) {
        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory({required String categoryId}) async {
    if (await networkInfo.isConnected) {
      try {
        await dashBoardRemoteDataSource.deleteCategory(categoryId: categoryId);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      } catch (error) {
        print(error.toString());
        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCategory({required CategoryEntity categoryEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await dashBoardRemoteDataSource.updateCategory(categoryModel: CategoryModel(categoryId: categoryEntity.categoryId, name: categoryEntity.name, imageUrl: categoryEntity.imageUrl));
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      } catch (error) {
        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBook({required BookEntity bookEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        await dashBoardRemoteDataSource.updateBook(
            bookModel: BookModel(bookId: bookEntity.bookId, title: bookEntity.title, description: bookEntity.description, bookCover: bookEntity.bookCover, bookPdf: bookEntity.bookPdf, rate: bookEntity.rate, numberOfPages: bookEntity.numberOfPages, bookVersion: bookEntity.bookVersion, categoryId: bookEntity.categoryId, publishingDate: bookEntity.publishingDate, author: bookEntity.author, bookRatingCount: bookEntity.bookRatingCount, bookReviewCount: bookEntity.bookReviewCount));
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      } catch (error) {
        return left(UnknowFailure());
      }
    } else {
      return left(ConnectionFailure());
    }
  }
}
