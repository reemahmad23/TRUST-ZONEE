import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trust_zone/features/random_user1/presentation/widget/user_info_row.dart';
import 'package:trust_zone/utils/app_strings.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../utils/color_managers.dart';
import '../cubit/user_profile_cubit.dart';
import '../cubit/user_profile_state.dart';

class RandomUser1ProfileSection extends StatelessWidget {
  const RandomUser1ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserProfileError) {
          return Center(child: Text(state.message));
        } else if (state is UserProfileLoaded) {
          final user = state.profile;
          final registrationDate =
          DateFormat.yMMMMd().format(DateTime.parse(user.registrationDate));

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(32),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(32),
                        ),
                        child: user.coverPictureUrl!.isNotEmpty
                            ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              user.coverPictureUrl!,
                              fit: BoxFit.cover,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorManager.mediumBlackOpacity,
                                    ColorManager.lightBlackOpacity,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        )
                            : Container(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    // Profile Picture with shadow and border
                    Positioned(
                      bottom: -50,
                      child: GestureDetector(
                        onTap: () {
                          if (user.profilePictureUrl != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Scaffold(
                                  appBar: AppBar(),
                                  body: Center(
                                    child: Image.network(user.profilePictureUrl!),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.blackShadow,
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: Border.all(
                              color: ColorManager.white,
                              width: 4,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: user.profilePictureUrl != null
                                ? NetworkImage(user.profilePictureUrl!)
                                : null,
                            backgroundColor: ColorManager.lightGrey,
                            child: user.profilePictureUrl == null
                                ? const Icon(Icons.person, size: 60)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 70),

                // User Name
                Text(
                  user.userName,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Info Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorManager.extraLightGrey,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.shadowGrey,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        UserInfoRow(icon: Iconsax.direct, text: user.email),
                        const SizedBox(height: 12),
                        UserInfoRow(
                            icon: Iconsax.calendar,
                            text: 'Joined: $registrationDate'),
                        const SizedBox(height: 12),
                        UserInfoRow(
                            icon: Iconsax.user, text: '${user.age} years old'),
                        const SizedBox(height: 12),
                        if (user.disabilityTypes.isNotEmpty)
                          UserInfoRow(
                            icon: Icons.accessibility_new_rounded,
                            text: user.disabilityTypes.map((d) => d.name).join(', '),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Send Message Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: {
                          'userId': user.id,
                          'userName': user.userName,
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorManager.lightBlueBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ColorManager.mintGreen),
                      ),
                      child: InkWell(
                        onTap: () {
                        context.push(
                          '/chat-screen',
                        extra: {
                          'receiverId': user.id,
                            },
                          );
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat, color: ColorManager.primary),
                             SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context).sendMessage,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}
