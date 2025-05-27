import 'package:equatable/equatable.dart';
import 'package:trust_zone/features/place_details/domain/entities/review_entity.dart';


abstract class ReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}
class ReviewAdded extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<ReviewEntity> reviews;

  ReviewLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
class ReviewSuccess extends ReviewState {
  final String message;
  ReviewSuccess(this.message);
}

