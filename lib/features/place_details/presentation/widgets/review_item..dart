import 'package:flutter/material.dart';
import 'package:trust_zone/features/random_user1/presentation/page/random_user1_page.dart';
import '../../../../utils/shared_data.dart';

class ReviewItem extends StatelessWidget {
  final String username;
  final String date;
  final int rating;
  final String reviewText;
  final String imageUrl;
  final String userId;


  const ReviewItem({
    super.key,
    required this.userId,
    required this.username,
    required this.date,
    required this.rating,
    required this.reviewText,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setSelectedUserId(userId);
        Navigator.push(
          context,
          MaterialPageRoute(

            builder: (_) => RandomUser1Page(
              userId:userId  ,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(imageUrl),
                ),

                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(date),
                  ],
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                    rating,
                        (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(reviewText),
          ],
        ),
      ),
    );
  }
}
