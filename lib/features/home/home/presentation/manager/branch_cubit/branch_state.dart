
import '../../../domain/entities/place_entity.dart';


abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchLoading extends BranchState {}

class BranchLoaded extends BranchState {
  final List<Branch> branches;

  BranchLoaded(this.branches);
}

class BranchError extends BranchState {
  final String message;

  BranchError(this.message);
}
