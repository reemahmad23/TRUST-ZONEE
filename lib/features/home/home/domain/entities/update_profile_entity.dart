class UpdateProfileEntity {
  final String userName;
  final String email;
  final int age;
  final String profilePictureUrl;
  final List<String> disabilityTypes;

  UpdateProfileEntity({
    required this.userName,
    required this.email,
    required this.age,
    required this.profilePictureUrl,
    required this.disabilityTypes,
  });
}
