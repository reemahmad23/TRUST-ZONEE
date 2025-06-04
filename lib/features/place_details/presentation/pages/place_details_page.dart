import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../injection_container.dart';
import '../../../../utils/color_managers.dart';
import '../../../../utils/custom_button.dart';
import '../cubit/place_details_cubit.dart';
import '../cubit/place_details_state.dart';
import '../cubit/review_cubit.dart';
import '../widgets/add_review_modal.dart';
import '../widgets/place_image_section.dart';
import '../widgets/review_list_view.dart';

class PlaceDetailsPage extends StatelessWidget {
  final int branchId;

  const PlaceDetailsPage({super.key, required this.branchId});

  @override
  Widget build(BuildContext context) {
    final int id = int.tryParse(branchId.toString()) ?? 1;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ReviewCubit>()..getUserReviewsByBranchId(id),
        ),
        BlocProvider(
          create: (_) => sl<PlaceDetailsCubit>()..getPlaceDetails(id),
        ),
      ],
      child: Scaffold(

        body: Column(
          children: [
            BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
              builder: (context, state)
              {
                if (state is PlaceDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PlaceDetailsLoaded) {
                  final placeDetails = state.branchEntity;
                  final photos = state.photos;
                  return PlaceImageSection(
                    branchId: id,
                    placeDetails: placeDetails,
                    photos: photos,
                  );
                } else if (state is PlaceDetailsError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("No data available"));
              },
            ),
            Align(
              alignment:Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(

                  AppLocalizations.of(context).reviews,
                  style: TextStyle(

                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),


            Expanded(
                child: Container(
                    color:  ColorManager.primary,
                    child: ReviewListView())),
            Padding(
              padding:  EdgeInsets.all(16.0),
              child: CustomButton(
                label:AppLocalizations.of(context).addReview,

                onPressedAction: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => BlocProvider.value(
                      value: context.read<ReviewCubit>(),
                      child: AddReviewModal(branchId: branchId),
                    ),
                  );
                },
                backgroundColor: ColorManager.primary,
                textColor: Colors.white ,
                height: 70,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
