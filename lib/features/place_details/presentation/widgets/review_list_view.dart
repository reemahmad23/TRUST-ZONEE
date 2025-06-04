import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/features/place_details/presentation/widgets/review_item..dart';
import '../cubit/review_cubit.dart';
import '../cubit/review_state.dart';

class ReviewListView extends StatelessWidget {
  const ReviewListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewLoaded) {
          return ListView.builder(
            itemCount: ReviewCubit.get(context).reviews.length,
            itemBuilder: (context, index) {
              final review =ReviewCubit.get(context).reviews[index];
              return ReviewItem(
                userId: review.user.id,
                username: review.user.userName,
                date: review.createdAt.toString(),
                rating: review.rating,
                reviewText: review.comment,
                imageUrl:review.user.profilePictureUrl,
              );
            },
          );


        } else if (state is ReviewError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
