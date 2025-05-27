import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_zone/features/chat/chat/data/repos/message_repo_im.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/messages_repo.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/message_cubit/message_cubit.dart';
import 'package:trust_zone/features/random_user1/data/datasource/user_profile_remote_data_source.dart';
import 'package:trust_zone/features/random_user1/data/datasource/user_profile_remote_data_source_impl.dart';
import 'package:trust_zone/features/random_user1/data/repositories/user_profile_repository_impl.dart';
import 'package:trust_zone/features/random_user1/domain/repositories/user_profile_repository.dart';
import 'package:trust_zone/features/random_user1/domain/usecase/get_user_profile.dart';
import 'package:trust_zone/features/random_user1/presentation/cubit/user_profile_cubit.dart';
import 'package:trust_zone/utils/chat_service.dart';
import 'package:trust_zone/utils/fav_api_service.dart';
import 'package:trust_zone/utils/profile_api_service.dart';
import 'package:trust_zone/utils/token_helper.dart';

import 'features/auth/data/datasource/auth_remote_datasource.dart';
import 'features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/repositories/auth_repo.dart';
import 'features/auth/domain/usecases/login_use_case.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/events/data/datasources/event_remote_data_source.dart';
import 'features/events/data/repositories/event_repository_impl.dart';
import 'features/events/domain/repositories/event_repository.dart';
import 'features/events/presentation/cubit/event_cubit.dart';

// Reviews

import 'features/home/home/data/data_sources/category_remote_data_source.dart';
import 'features/home/home/data/data_sources/profile_remote_data_source.dart';
import 'features/home/home/data/repo/category_repo_im.dart';
import 'features/home/home/data/repo/favorite_repo_im.dart';
import 'features/home/home/data/repo/place_repo_im.dart';
import 'features/home/home/data/repo/profile_repo_im.dart';
import 'features/home/home/domain/repo/category_repo.dart';
import 'features/home/home/domain/repo/favorite.dart';
import 'features/home/home/domain/repo/place_repo.dart';
import 'features/home/home/domain/repo/profile_repo.dart';
import 'features/home/home/domain/use_cases/favorite_usecase.dart';
import 'features/home/home/domain/use_cases/get_category_id.dart';
import 'features/home/home/domain/use_cases/get_places.dart';
import 'features/home/home/domain/use_cases/get_profile_use_case.dart';
import 'features/home/home/domain/use_cases/update_profile_use_case.dart';
import 'features/home/home/presentation/manager/branch_cubit/branch_cubit.dart';
import 'features/home/home/presentation/manager/category_cubit/category_cubit.dart';
import 'features/home/home/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'features/home/home/presentation/manager/profile_cubit/profile_cubit.dart';
import 'features/place_details/data/datasources/place_details_remote_data_source.dart';
import 'features/place_details/data/datasources/place_details_remote_data_source_impl.dart';
import 'features/place_details/data/datasources/review_remote_data_source.dart';
import 'features/place_details/data/datasources/review_remote_data_source_impl.dart';
import 'features/place_details/data/repositories/place_details_repository_impl.dart';
import 'features/place_details/data/repositories/review_repository_impl.dart';
import 'features/place_details/domain/repositories/place_details_repository.dart';
import 'features/place_details/domain/repositories/review_repository.dart';
import 'features/place_details/domain/usecaces/create_review_usecase.dart';
import 'features/place_details/domain/usecaces/get_branch_details.dart';
import 'features/place_details/domain/usecaces/get_branch_photos.dart';
import 'features/place_details/domain/usecaces/get_user_reviews_usecase.dart';
import 'features/place_details/presentation/cubit/place_details_cubit.dart';
import 'features/place_details/presentation/cubit/review_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token');
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Auth
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));

  // Reviews
  sl.registerFactory(() => ReviewCubit(
    addReviewUseCase: sl(),
    getUserReviewsUseCase: sl(),
  ));
  sl.registerLazySingleton(() => CreateReviewUseCase(sl()));
  sl.registerLazySingleton(() => GetUserReviewsUseCase(sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl(),remoteDataSource: sl() ));
  sl.registerLazySingleton<ReviewRemoteDataSource>(() => ReviewRemoteDataSourceImpl(sl<Dio>()));

  // Events
  sl.registerFactory(() => EventCubit(sl()));
  sl.registerLazySingleton<EventRepository>(() => EventRepositoryImpl(sl()));
  sl.registerLazySingleton<EventRemoteDataSource>(() => EventRemoteDataSourceImpl(sl<Dio>()));

// Place Details
  sl.registerFactory(() => PlaceDetailsCubit(
    getBranchDetailsUseCase: sl(),
    getBranchPhotosUseCase: sl(),
  ));
  sl.registerLazySingleton(() => GetBranchDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetBranchPhotosUseCase(sl()));
  sl.registerLazySingleton<PlaceDetailsRepository>(() => PlaceDetailsRepositoryImpl(sl()));
  sl.registerLazySingleton<PlaceDetailsRemoteDataSource>(() => PlaceDetailsRemoteDataSourceImpl(sl<Dio>()));

 // User Profile
  // User Profile
  sl.registerFactory(() => UserProfileCubit(sl()));
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton<UserProfileRepository>(() => UserProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<UserProfileRemoteDataSource>(() => UserProfileRemoteDataSourceImpl(sl<Dio>()));

// ---------------------- Profile ----------------------
  sl.registerLazySingleton<ProfileApiService>(
        () => ProfileApiService(sl<Dio>()),
  );

// Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(sl()),
  );

// Repository
  sl.registerLazySingleton<ProfileRepo>(
        () => ProfileRepoImpl(sl()),
  );

// Use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));

// Cubit
  sl.registerFactory(() => ProfileCubit(
    getProfileUseCase: sl(),
    updateProfileUseCase: sl(),
  ));

// ---------------------- Category ----------------------
  sl.registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoryByIdUseCase(sl()));
  sl.registerLazySingleton(() => AddCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));

  sl.registerFactory(() => CategoryCubit(
    getCategoriesUseCase: sl(),
    getCategoryByIdUseCase: sl(),
    addCategoryUseCase: sl(),
    updateCategoryUseCase: sl(),
    deleteCategoryUseCase: sl(),
  ));

// ---------------------- Branch ----------------------
  // ---------------------- Branch ----------------------
  sl.registerLazySingleton<BranchRepository>(
        () => BranchRepositoryImpl(apiService: sl()),
  );

  sl.registerLazySingleton(() => GetBranchesByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => SearchBranchesUseCase(sl()));

  sl.registerFactory<BranchCubit>(() => BranchCubit(sl(), sl()));



  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl(sl()));

  // Repository
  sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));

  // Cubit
  sl.registerFactory(() => FavoriteCubit(
    addFavorite: sl(),
    deleteFavorite: sl(),
    getFavorites: sl(),
  ));


sl.registerLazySingleton(() => ChatApiService(sl())); 
// Dio لازم تكون مسجلة
sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

sl.registerFactory(() => ChatCubit(sl()));



//   // Data Source
//   sl.registerLazySingleton<ConversationRemoteDataSource>(
//         () => ConversationRemoteDataSourceImpl(sl(), token),
//   );

// // Repository
//   sl.registerLazySingleton<ConversationRepository>(
//         () => ConversationRepositoryImpl(sl()),
//   );

// // Use Cases
//   sl.registerLazySingleton(() => GetConversationsUseCase(sl()));
//   sl.registerLazySingleton(() => CreateConversationUseCase(sl()));

// // Cubit
//   sl.registerFactory(() => ConversationCubit(
//     sl(),
//     sl(),
//   ));




//   sl.registerLazySingleton(() => ChatService(baseUrl: 'https://trustzone.azurewebsites.net', token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkb25pYTEyMyIsImp0aSI6IjJmNWI2MjJkLWRjNWQtNDBlZS1hZTUwLWYxMDgzOWNkNmMxNiIsIlVpZCI6IjU3NTBhNWNhLWQ4MDctNGExMC04ZDYwLTc1NDg2NmZjODcyZCIsInJvbGVzIjoiVXNlciIsImV4cCI6MTc0Nzg1Mzc4OCwiaXNzIjoiVHJ1c3Rab25lIiwiYXVkIjoiVHJ1c3Rab25lVXNlciJ9.2VzM558dhp7-ia_o3v2FevStIPg8_8hHybK2kmjDiJk"));
  
  
//   sl.registerLazySingleton<MessageRepository>(
//         () => MessageRepositoryImpl(sl()),
//   );
//   sl.registerLazySingleton(() => GetMessagesUseCase(sl<MessageRepository>()));
//   sl.registerLazySingleton(() => SendMessageUseCase(sl<MessageRepository>()));
  
//   sl.registerFactory(() => ChatCubit(
//     sl(),
//     sl(),
//   ));
  
  


}