import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_places.dart';
import 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final GetBranchesByCategoryUseCase useCase;
  final SearchBranchesUseCase searchBranchesUseCase;

  BranchCubit(this.useCase, this.searchBranchesUseCase) : super(BranchInitial());

  void getBranches(int categoryId) async {
    emit(BranchLoading());
    try {
      final branches = await useCase(categoryId);
      emit(BranchLoaded(branches));
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }

  void searchBranches({required String query, int page = 1, int pageSize = 10}) async {
    emit(BranchLoading());

    try {
      final branches = await searchBranchesUseCase(query, page, pageSize);
      emit(BranchLoaded(branches));
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }
}