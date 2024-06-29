import 'package:dio/dio.dart';
import 'package:fruit_e_commerce/core/constants/api_strings.dart';
import 'package:fruit_e_commerce/core/network/network_info.dart';
import 'package:fruit_e_commerce/features/admin/data/data_sources/dashboard_remote_datasource.dart';
import 'package:fruit_e_commerce/features/admin/data/repositories_impl/dashboard_repository_impl.dart';
import 'package:fruit_e_commerce/features/admin/domain/repositories/dash_board_repository.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/add_book_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/add_category_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/delete_book_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/delete_category_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/update_book_usecase.dart';
import 'package:fruit_e_commerce/features/admin/domain/use_cases/update_category_usecase.dart';
import 'package:fruit_e_commerce/features/admin/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:fruit_e_commerce/features/authors/data/data_sources/auth_remote_data_source.dart';
import 'package:fruit_e_commerce/features/authors/data/repositories_impl/authors_repo_impl.dart';
import 'package:fruit_e_commerce/features/authors/domain/repositories/authors_repository.dart';
import 'package:fruit_e_commerce/features/authors/domain/use_cases/get_all_authors_usecase.dart';
import 'package:fruit_e_commerce/features/authors/presentation/blocs/bloc/author_bloc.dart';
import 'package:fruit_e_commerce/features/category/data/data_sources/category_remote_datasource.dart';
import 'package:fruit_e_commerce/features/category/data/repositories_impl/category_repository_impl.dart';
import 'package:fruit_e_commerce/features/category/domain/repositories/category_repository.dart';
import 'package:fruit_e_commerce/features/category/domain/use_cases/get_all_categories_usecase.dart';
import 'package:fruit_e_commerce/features/category/domain/use_cases/get_category_books_usecase.dart';
import 'package:fruit_e_commerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:fruit_e_commerce/features/favourites/data/data_sources/favourites_remote_datasource.dart';
import 'package:fruit_e_commerce/features/favourites/data/repositories_impl/favoutites_remote_datasource_impl.dart';
import 'package:fruit_e_commerce/features/favourites/domain/repositories/favourites_repository.dart';
import 'package:fruit_e_commerce/features/favourites/domain/use_cases/add_booktofavourite_usecase.dart';
import 'package:fruit_e_commerce/features/favourites/domain/use_cases/delete_bookfromfavourite_usecase.dart';
import 'package:fruit_e_commerce/features/favourites/domain/use_cases/get_user_favourites_usecase.dart';
import 'package:fruit_e_commerce/features/favourites/presentation/blocs/bloc/favourites_bloc.dart';
import 'package:fruit_e_commerce/features/home/data/data_sources/remote_data_source.dart';
import 'package:fruit_e_commerce/features/home/data/repositories_impl/home_repository_impl.dart';
import 'package:fruit_e_commerce/features/home/domain/repositories/home_repository.dart';
import 'package:fruit_e_commerce/features/home/domain/use_cases/get_all_books_usecase.dart';
import 'package:fruit_e_commerce/features/home/presentation/blocs/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;
Future<void> init() async {
//bloc
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(() => CategoryBloc(sl(), sl()));
  sl.registerFactory(() => FavouritesBloc(sl(), sl(), sl()));
  sl.registerFactory(() => DashboardBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => AuthorBloc(sl()));

//usecase
  sl.registerLazySingleton(() => GetAllBooksUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => GetAllCategoriesUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => GetCategoryBooksUSeCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => GetUserFavouritesUseCase(favouritesRepository: sl()));
  sl.registerLazySingleton(() => AddBookToFavouriteUseCase(favouritesRepository: sl()));
  sl.registerLazySingleton(() => DeleteBookFromFavouritesUseCase(favouritesRepository: sl()));
  sl.registerLazySingleton(() => AddBookUseCase(dashBoardRepository: sl()));
  sl.registerLazySingleton(() => AddCategoryUseCase(dashBoardRepository: sl()));
  sl.registerLazySingleton(() => DeleteBookUseCase(dashBoardRepository: sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(dashBoardRepository: sl()));
  sl.registerLazySingleton(() => UpdateBookUseCase(sl()));
  sl.registerLazySingleton(() => GetAllAuthorsUsecase(sl()));

//repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(networkInfo: sl(), categoryRemoteDataSource: sl()));
  sl.registerLazySingleton<FavouritesRepository>(() => FavouritesRepositoryImpl(networkInfo: sl(), favouritesRemoteDataSource: sl()));
  sl.registerLazySingleton<DashBoardRepository>(() => DashBoardRepositoryImpl(sl(), sl()));
  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<AuthorsRepository>(() => AuthorsRepoImpl(authRemoteDataSource: sl(), networkInfo: sl()));

//datasource
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImplWithDio(dio: sl()));
  sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImplWithDio(dio: sl()));
  sl.registerLazySingleton<FavouritesRemoteDataSource>(() => FavouritesRemoteDataSourceImplWithDio(dio: sl()));
  sl.registerLazySingleton<DashBoardRemoteDataSource>(() => DashBoardRemoteDataSourceImpWithDio(dio: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceWithDio(dio: sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  const String baseUrl = ApiStrings.baseUrl;
  BaseOptions options = BaseOptions(
    baseUrl: baseUrl,
    contentType: 'application/json',
    receiveDataWhenStatusError: true,
  );

  sl.registerLazySingleton(() => Dio(options));
}
