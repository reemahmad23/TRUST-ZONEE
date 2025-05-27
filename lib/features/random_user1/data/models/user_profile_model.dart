class DisabilityTypeModel {
  final int id;
  final String name;

  DisabilityTypeModel({required this.id, required this.name});

  factory DisabilityTypeModel.fromJson(Map<String, dynamic> json) {
    return DisabilityTypeModel(
      id: json['id'],
      name: json['name']??"",
    );
  }
}

class UserProfileModel {
  final String id;
  final String userName;
  final String email;
  final int age;
  final String? profilePictureUrl;
  final String? coverPictureUrl;
  final String registrationDate;
  final bool isActive;
  final List<DisabilityTypeModel> disabilityTypes;

  UserProfileModel({
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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id']??"",
      userName: json['userName']??"",
      email: json['email']??"",
      age: json['age'],
      profilePictureUrl: json['profilePictureUrl']??"",
      coverPictureUrl: json['coverPictureUrl']??"",
      registrationDate: json['registrationDate']??"",
      isActive: json['isActive'],
      disabilityTypes: (json['disabilityTypes'] as List)
          .map((e) => DisabilityTypeModel.fromJson(e))
          .toList(),
    );
  }
}
