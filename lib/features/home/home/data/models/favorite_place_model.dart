
import 'package:trust_zone/features/home/home/data/models/place.dart';

class FavoriteModel {
  final int id;
  final BranchModel branch;

  FavoriteModel({
    required this.id,
    required this.branch,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      branch: BranchModel.fromJson(json['branch']),
    );
  }
}