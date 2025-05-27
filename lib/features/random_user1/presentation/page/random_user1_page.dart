import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../injection_container.dart';
import '../../domain/usecase/get_user_profile.dart';
import '../cubit/user_profile_cubit.dart';
import '../widget/random_user_profile_section.dart';

class RandomUser1Page extends StatelessWidget {
  const RandomUser1Page({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileCubit(sl<GetUserProfile>())..fetchUserProfile(userId),
      child: Scaffold(
        appBar: AppBar(
          actions: [BackButton()],
        ),
        body: const SingleChildScrollView(
          child: RandomUser1ProfileSection(),
        ),
      ),
    );
  }
}
