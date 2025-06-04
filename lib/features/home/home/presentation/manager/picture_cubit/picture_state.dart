abstract class PictureState {}
class PictureInitial extends PictureState {}
class PictureUploading extends PictureState {}
class PictureImageUploaded extends PictureState {
  final String imageUrl;
  PictureImageUploaded(this.imageUrl);
}
class PictureError extends PictureState {
  final String message;
  PictureError(this.message);
}