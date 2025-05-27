class UserProfile {
  final String userName;
  final String email;
  final int age;
  final String profilePictureUrl;
  final List<String> disabilityTypes;

  UserProfile({
    required this.userName,
    required this.email,
    required this.age,
    required this.profilePictureUrl,
    required this.disabilityTypes,
  });

  UserProfile copyWith({
    String? userName,
    String? email,
    int? age,
    String? profilePictureUrl,
    List<String>? disabilityTypes,
  }) {
    return UserProfile(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      age: age ?? this.age,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      disabilityTypes: disabilityTypes ?? this.disabilityTypes,
    );
  }
}
