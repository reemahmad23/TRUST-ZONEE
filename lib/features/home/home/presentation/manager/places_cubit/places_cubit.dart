// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trust_zone/features/home/domain/repo/place_repo.dart';
// import 'package:trust_zone/features/home/presentation/manager/places_cubit/place_state.dart';

// class PlacesCubit extends Cubit<PlacesState> {
//   final GetPlacesUseCase getPlacesUseCase;

//   PlacesCubit(this.getPlacesUseCase) : super(PlacesInitial());

//   Future<void> fetchPlaces() async {
//     emit(PlacesLoading());
//     try {
//       final places = await getPlacesUseCase.execute();
//       emit(PlacesLoaded(places));
//     } catch (e) {
//       emit(PlacesError("فشل تحميل الأماكن: $e"));
//     }
//   }
// }
