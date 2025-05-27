
import '../../domain/entities/branch_entity.dart';
import '../../domain/entities/branch_photo.dart';

abstract class PlaceDetailsState {}

class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsLoading extends PlaceDetailsState {}

class PlaceDetailsLoaded extends PlaceDetailsState {
  final BranchEntity branchEntity;
  final List<BranchPhotoEntity> photos;

  PlaceDetailsLoaded({required this.branchEntity, required this.photos});
}

class PlaceDetailsError extends PlaceDetailsState {
  final String message;

  PlaceDetailsError({required this.message});
}
