import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../injection_container.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../manager/profile_cubit/profile_cubit.dart';


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
     BlocProvider(
 create: (context) => sl<ProfileCubit>()..fetchUserProfile(),
   child: 
  Drawer(
      backgroundColor: const Color(0xFF62B6CB),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          UserProfile? profile;
          if (state is ProfileLoaded) {
            profile = state.profile;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push('/profile-view');
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: (profile?.profilePictureUrl != null)
                            ? NetworkImage(profile!.profilePictureUrl!)
                            : null,
                        child: (profile?.profilePictureUrl == null)
                            ? const Icon(Icons.person)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile?.userName ?? '',
                            style: const TextStyle(color: Colors.white)),
                        Text(profile?.email ?? '',
                            style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(AppLocalizations.of(context).settings),
                      onTap: () => context.push('/settings'),
                    ),
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text(AppLocalizations.of(context).events),
                      onTap: () => context.push('/eventPage'),
                    ),
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text(AppLocalizations.of(context).help),
                      onTap: () => context.push('/helpCenter'),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(AppLocalizations.of(context).logOut),
                      onTap: () => context.push('/login'),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
  )
    );
  }
}