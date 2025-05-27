class ReviewRequestModel {
  final int branchId;
  final int rating;
  final String comment;


  ReviewRequestModel({
    required this.branchId,
    required this.rating,
    required this.comment,

  });

  Map<String, dynamic> toJson() {
    return {
      "branchId": branchId,
      "rating": rating,
      "comment": comment,

    };
  }
}
