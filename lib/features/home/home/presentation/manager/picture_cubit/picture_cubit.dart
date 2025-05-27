//
// import 'dart:io';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trust_zone/features/home/home/presentation/manager/picture_cubit/picture_state.dart';
//
// class PictureCubit extends Cubit<PictureState> {
//   final PictureApiService apiService;
//
//   PictureCubit(this.apiService) : super(PictureInitial());
//
//   Future<void> uploadPicture(File imageFile, String token) async {
//     try {
//       emit(PictureLoading());
//
//       // الحصول على رابط SAS من الـ API
//       final sasUrl = await apiService.generatePictureUploadSas(token);
//
//       // رفع الصورة باستخدام رابط SAS
//       await apiService.uploadPicture(imageFile, sasUrl);
//
//       // إذا تم الرفع بنجاح، قم بتحديث الصورة
//       emit(PictureUpdated(imageUrl: sasUrl));
//     } catch (e) {
//       emit(PictureError(message: 'فشل في رفع صورة البروفايل'));
//     }
//   }
// }
