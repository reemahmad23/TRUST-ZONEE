import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_user_profile.dart';
import 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfile getUserProfileUseCase;

  UserProfileCubit(this.getUserProfileUseCase) : super(UserProfileInitial());

  Future<void> fetchUserProfile(String userId) async {
    emit(UserProfileLoading());
    try {
      final profile = await getUserProfileUseCase(userId);
      emit(UserProfileLoaded(profile));
    } catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }
}
