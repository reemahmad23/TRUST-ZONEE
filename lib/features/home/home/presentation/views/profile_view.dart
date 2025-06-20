import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trust_zone/features/home/home/presentation/views/widgets/custom_error_widget.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../injection_container.dart';
import '../manager/profile_cubit/profile_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<ProfileCubit>()..fetchUserProfile();
  }

  String? uploadedImageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          centerTitle: true,
          title: Text(AppLocalizations.of(context).profile),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return CustomErrorWidget(message: state.message);
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: uploadedImageUrl != null
                        ? NetworkImage(
                            uploadedImageUrl!.contains('?')
                                ? '${uploadedImageUrl!}&v=${DateTime.now().millisecondsSinceEpoch}'
                                : '${uploadedImageUrl!}?v=${DateTime.now().millisecondsSinceEpoch}',
                          )
                        : (profile.profilePictureUrl != null
                            ? NetworkImage(
                                profile.profilePictureUrl!.contains('?')
                                    ? '${profile.profilePictureUrl!}&v=${DateTime.now().millisecondsSinceEpoch}'
                                    : '${profile.profilePictureUrl!}?v=${DateTime.now().millisecondsSinceEpoch}',
                              )
                            : null),
                    child: (uploadedImageUrl == null &&
                            profile.profilePictureUrl == null)
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ProfileItem(
                      icon: Icons.person, text: profile.userName ?? 'No name'),
                  ProfileItem(
                      icon: Icons.email, text: profile.email ?? 'No email'),
                  ProfileItem(
                      icon: Icons.accessibility,
                      text: profile.age?.toString() ?? 'No age'),
                  ProfileItem(
                    icon: Icons.favorite,
                    text: AppLocalizations.of(context).myFavorites,
                    onTap: () {
                      context.push('/favorites');
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       ElevatedButton.icon(
  onPressed: () async {
    final result = await context.push('/editProfile');
    if (result != null && result is String) {
      setState(() {
        uploadedImageUrl = result;
      });
      _cubit.fetchUserProfile();
    }
  },
  icon: const Icon(Icons.edit, size: 28), // تكبير الأيقونة
  label: Text(
    AppLocalizations.of(context).edit,
    style: const TextStyle(fontSize: 18), // تكبير الخط
  ),
),

ElevatedButton.icon(
  onPressed: () {
    context.push('/login');
  },
  icon: const Icon(Icons.logout, color: Colors.white, size: 28), // تكبير الأيقونة
  label: Text(
    AppLocalizations.of(context).logOut,
    style: const TextStyle(color: Colors.white, fontSize: 18), // تكبير الخط
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1B4965),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  ),
),

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            } else {
              return Center(
                  child: Text(AppLocalizations.of(context).unexpected));
            }
          },
        ),
      ),
    );
  }
}
class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(20), // زيادة المسافة الداخلية
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30), // تكبير الأيقونة
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18, // تكبير الخط
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
