import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trust_zone/features/place_details/presentation/pages/place_details_page.dart';
import 'package:trust_zone/utils/app_strings.dart';
import 'package:trust_zone/utils/color_managers.dart';
import 'package:trust_zone/utils/shared_data.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubit/review_cubit.dart';
import '../cubit/review_state.dart';

class AddReviewModal extends StatefulWidget {
  final int branchId;

  const AddReviewModal({super.key, required this.branchId});

  @override
  State<AddReviewModal> createState() => _AddReviewModalState();
}

class _AddReviewModalState extends State<AddReviewModal> {
  int rating = 4;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) async {
        if (state is ReviewSuccess) {
          await context
              .read<ReviewCubit>()
              .getUserReviewsByBranchId(widget.branchId);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context).reviewAddedSuccessfully)),
          );
        } else if (state is ReviewError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('${AppStrings.failedToAddReview} ${state.message}')),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        decoration: const BoxDecoration(
          color: Color(0xFF0E4A5B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Text(AppLocalizations.of(context).giveAReview,
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < rating ? Colors.amber : Colors.white,
                    size: 28,
                  ),
                  onPressed: () => setState(() => rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).detailReview,
                  style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 4,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8EC9DB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () async {
                final comment = _controller.text.trim();
                if (comment.isEmpty) return;
                await context
                    .read<ReviewCubit>()
                    .addReview(
                      branchId: widget.branchId,
                      rating: rating,
                      comment: comment,
                    )
                    .then((val) async {
                  await context
                      .read<ReviewCubit>()
                      .getUserReviewsByBranchId(widget.branchId);
                });
              },
              child: Text(
                AppLocalizations.of(context).sendReview,
                style: TextStyle(color: ColorManager.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
