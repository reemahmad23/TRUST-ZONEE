import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_zone/features/random_user1/presentation/cubit/user_profile_cubit.dart';
import 'package:trust_zone/features/random_user1/presentation/page/random_user1_page.dart';
import 'package:trust_zone/utils/app_router.dart';
import 'package:trust_zone/utils/shared_data.dart';
import 'package:trust_zone/utils/token_helper.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'features/place_details/presentation/cubit/place_details_cubit.dart';
import 'features/place_details/presentation/pages/place_details_page.dart';
import 'injection_container.dart' as di;
import 'core/network/dio_helper.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/place_details/presentation/cubit/review_cubit.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
final currentUserId = await TokenHelper.getUserId(); // ✅ صح كده

  di.init(currentUserId: currentUserId ?? '');
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const TrustZone(),
    ),
  );
}

class TrustZone extends StatelessWidget {
  const TrustZone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocaleCubit>(
            create: (_) => LocaleCubit(),
          ),
          BlocProvider(create: (_) => di.sl<AuthCubit>()),
          BlocProvider(
              create: (_) => di.sl<ReviewCubit>()
                ..getUserReviewsUseCase
                ..addReviewUseCase),
          BlocProvider(
            create: (_) =>
                di.sl<PlaceDetailsCubit>()..getPlaceDetails(1), //هشغلها
            child: const PlaceDetailsPage(branchId: 1),
          ),
          BlocProvider(
            create: (context) => UserProfileCubit(di.sl())..fetchUserProfile(userId),
            child: RandomUser1Page(userId: userId,),
          )
        ],
        child: BlocBuilder<LocaleCubit, Locale>(
    builder: (context, locale)
    {
    return MaterialApp.router(
    useInheritedMediaQuery: true,
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    ],
    builder: DevicePreview.appBuilder,
    title: 'Trust Zone',
    debugShowCheckedModeBanner: false,
    routerConfig: AppRouter.router,
    );
    },
        ));

  }
}
