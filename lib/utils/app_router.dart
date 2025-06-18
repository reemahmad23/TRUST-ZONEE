import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trust_zone/features/auth/presentation/views/login_view.dart';
import 'package:trust_zone/features/auth/presentation/views/logo_view.dart';
import 'package:trust_zone/features/auth/presentation/views/sign_up_view.dart';
import 'package:trust_zone/features/events/presentation/pages/event_page.dart';
import 'package:trust_zone/features/help_page/page/help_page.dart';
import 'package:trust_zone/features/place_details/presentation/pages/place_details_page.dart';
import 'package:trust_zone/features/random_user1/presentation/page/random_user1_page.dart';
import 'package:trust_zone/utils/shared_data.dart';
import 'package:trust_zone/utils/shared_data.dart' as SharedData;
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/chat/chat/presentation/managerr/conversation_cubit/conversatoin_cubit.dart';
import '../features/chat/chat/presentation/managerr/message_cubit/message_cubit.dart';
import '../features/chat/chat/presentation/views/conversations.dart';
import '../features/chat/chat/presentation/views/chats_view.dart';
import '../features/events/presentation/cubit/event_cubit.dart';
import '../features/home/home/presentation/manager/branch_cubit/branch_cubit.dart';
import '../features/home/home/presentation/manager/category_cubit/category_cubit.dart';
import '../features/home/home/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../features/home/home/presentation/manager/profile_cubit/profile_cubit.dart';
import '../features/home/home/presentation/views/edit_profile_view.dart';
import '../features/home/home/presentation/views/favorites.dart';
import '../features/home/home/presentation/views/home_view.dart';
import '../features/home/home/presentation/views/places_view.dart';
import '../features/home/home/presentation/views/profile_view.dart';
import '../features/place_details/presentation/cubit/review_cubit.dart';
import '../features/settings/presentation/view/settings_view.dart';
import '../injection_container.dart' as di;

abstract class AppRouter {
  static final router = GoRouter(
    //initialLocation: '/review/1',
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LogoView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<AuthCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<AuthCubit>(),
          child: const SignUpView(),
        ),
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CategoryCubit>(
                create: (context) => di.sl<CategoryCubit>()..fetchCategories(),
              ),
              BlocProvider<BranchCubit>(
                create: (context) => di.sl<BranchCubit>(),
              ),
            ],
            child: const HomeView(),
          );
        },
      ),

      GoRoute(
        path: '/places-view',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;

          final int categoryId = extra['id'];
          final String categoryName = extra['name'];

          return PlacesView(
            categoryId: categoryId,
            categoryName: categoryName,
          );
        },
      ),

      GoRoute(
        path: '/profile-view',
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<ProfileCubit>()..fetchUserProfile(),
          child: const ProfileView(),
        ),
      ),
      GoRoute(
        path: '/editProfile',
        builder: (context, state) => BlocProvider.value(
          value: di.sl<ProfileCubit>(),
          child: const EditProfileView(),
        ),
      ),

      GoRoute(
        path: '/favorites',
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<FavoriteCubit>()
            ..loadFavorites(), // أو FavoriteCubit() حسب استخدامك
          child: const FavoritePlacesScreen(),
        ),
      ),
      GoRoute(
        path: '/eventPage',
        builder: (context, state) => BlocProvider<EventCubit>(
          create: (_) => di.sl<EventCubit>()..fetchEvents(),
          child: const EventsPage(),
        ),
      ),
      GoRoute(
        path: '/randoUser1Page',
        builder: (context, state) => RandomUser1Page(userId: userId),
      ),
      
      GoRoute(
        path: '/helpCenter',
        builder: (context, state) => const HelpCenterView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/review/:branchId',
        builder: (context, state) {
          final branchId = int.tryParse(state.pathParameters['branchId'] ?? '');
          if (branchId == null) {
            return const Scaffold(
              body: Center(child: Text("Invalid Branch ID")),
            );
          }
          return BlocProvider(
            create: (_) =>
                di.sl<ReviewCubit>()..getUserReviewsByBranchId(branchId),
            child: PlaceDetailsPage(branchId: branchId),
          );
        },
      ),
      GoRoute(
  path: '/chat-screen',
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;
    return BlocProvider(
      create: (context) => di.sl<ChatCubit>(), // أو ChatCubit(repository)
      child: ChatScreen(
        conversationId: extra['conversationId'],
        receiverId: extra['receiverId'],
        receiverName: extra['receiverName'],
                receiverProfilePicture: extra['receiverProfilePicture'],

      ),
    );
  },
),
     GoRoute(
  path: '/chat-list-screen',
  builder: (context, state) => BlocProvider(
    create: (_) => di.sl<ConversationCubit>(), // sl هو GetIt.instance
    child: const ChatListScreen(),
  ),
),


    ],

    
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text("No Route Found")),
    ),
  );

  
}
