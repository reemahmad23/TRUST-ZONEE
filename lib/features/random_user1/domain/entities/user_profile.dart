class DisabilityType {
  final int id;
  final String name;

  DisabilityType({required this.id, required this.name});
}

class UserProfile1 {
  final String id;
  final String userName;
  final String email;
  final int age;
  final String? profilePictureUrl;
  final String? coverPictureUrl;
  final String registrationDate;
  final bool isActive;
  final List<DisabilityType> disabilityTypes;

  UserProfile1({
    required this.id,
    required this.userName,
    required this.email,
    required this.age,
    this.profilePictureUrl,
    this.coverPictureUrl,
    required this.registrationDate,
    required this.isActive,
    required this.disabilityTypes,
  });
}
