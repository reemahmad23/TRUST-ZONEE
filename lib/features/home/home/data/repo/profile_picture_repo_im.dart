//
// import 'dart:io';
//
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:trust_zone/features/%20random_user1/domain/entities/user_profile.dart';
//
// import '../../../../../core/error/failure.dart';
//
// class UserProfileRepositoryImpl implements UserProfileRepository {
//   final Dio dio;
//   final String token;
//
//   UserProfileRepositoryImpl({required this.dio, required this.token});
//
//   @override
//   Future<Either<Failure, String>> uploadProfileImage(String filePath) async {
//     try {
//       final file = File(filePath);
//       final fileName = basename(file.path);
//
//       // Step 1: Get SAS Upload URL
//       final uploadUrlResponse = await dio.get(
//         'https://trustzone.azurewebsites.net/api/UserProfile/generateProfilePictureUploadSas',
//         options: Options(headers: {
//           'Authorization': 'Bearer $token',
//         }),
//       );
//
//       final uploadUrl = uploadUrlResponse.data.toString();
//
//       // Step 2: Upload Image to Azure Blob via SAS URL
//       await dio.put(
//         uploadUrl,
//         data: file.openRead(),
//         options: Options(
//           headers: {
//             'x-ms-blob-type': 'BlockBlob',
//             'Content-Type': 'image/jpeg',
//           },
//         ),
//       );
//
//       // Step 3: Tell backend you uploaded this file
//       await dio.put(
//         'https://trustzone.azurewebsites.net/api/UserProfile/ProfilePicture/$fileName',
//         options: Options(headers: {
//           'Authorization': 'Bearer $token',
//         }),
//       );
//
//       return Right(fileName);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
//
//
// }
