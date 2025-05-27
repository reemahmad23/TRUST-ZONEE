import 'package:dio/dio.dart';
import '../models/branch_model.dart';
import '../models/branch_photo_model.dart';
import 'place_details_remote_data_source.dart';

class PlaceDetailsRemoteDataSourceImpl implements PlaceDetailsRemoteDataSource {
  final Dio dio;

  PlaceDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<BranchModel> getBranchDetails(int branchId) async {
    final response = await dio.get('https://trustzone.azurewebsites.net/api/Branch/$branchId');
    return BranchModel.fromJson(response.data);
  }

  @override
  Future<List<BranchPhotoModel>> getBranchPhotos(int branchId) async {
    final response = await dio.get('https://trustzone.azurewebsites.net/api/BranchPhotos/branch/$branchId');
    return (response.data as List)
        .map((e) => BranchPhotoModel.fromJson(e))
        .toList();
  }
}
