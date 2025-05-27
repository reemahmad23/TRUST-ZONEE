import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecaces/get_branch_details.dart';
import '../../domain/usecaces/get_branch_photos.dart';
import 'place_details_state.dart';
class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final GetBranchDetailsUseCase getBranchDetailsUseCase;
  final GetBranchPhotosUseCase getBranchPhotosUseCase;

  PlaceDetailsCubit({
    required this.getBranchDetailsUseCase,
    required this.getBranchPhotosUseCase,
  }) : super(PlaceDetailsInitial());

  Future<void> getPlaceDetails(int branchId) async {
    emit(PlaceDetailsLoading());
    try {
      final details = await getBranchDetailsUseCase(branchId);
      final photos = await getBranchPhotosUseCase(branchId) ?? [];
      emit(PlaceDetailsLoaded(branchEntity: details, photos: photos));
    } catch (e) {
      emit(PlaceDetailsError(message: e.toString()));
    }
  }
}
