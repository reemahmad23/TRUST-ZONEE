import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../domain/entities/update_profile_entity.dart';
import '../manager/profile_cubit/profile_cubit.dart';


class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedAge;
  String? selectedDisabilityType;
  File? _image; // لتخزين الصورة الملتقطة

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().userProfile;
    if (profile != null) {
      nameController.text = profile.userName ?? '';
      emailController.text = profile.email ?? '';
      selectedAge = profile.age.toString();
      selectedDisabilityType = profile.disabilityTypes.join(', ');
    }
  }

  // دالة لاختيار صورة من المعرض أو الكاميرا
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // لتحديد مصدر الصورة من المعرض

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(AppLocalizations.of(context).editProfile, style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            Navigator.pop(context, state.updatedProfile);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: _image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(_image!),
                            )
                          : const Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                      onPressed: _pickImage, // اختيار الصورة عند الضغط على الأيقونة
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(controller: nameController, label: 'Username'),
                CustomTextField(controller: emailController, label: 'Email'),
                DropdownField(
                  label: AppLocalizations.of(context).age,
                  value: selectedAge,
                  items: List.generate(100, (index) => (index + 1).toString()),
                  onChanged: (val) => setState(() => selectedAge = val),
                ),
                DropdownField(
                  label: AppLocalizations.of(context).disabilityType,
                  value: selectedDisabilityType,
                  items: [AppLocalizations.of(context).visual, AppLocalizations.of(context).hearing, AppLocalizations.of(context).mobility, 'Cognitive'],
                  onChanged: (val) => setState(() => selectedDisabilityType = val),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    final entity = UpdateProfileEntity(
                      userName: nameController.text,
                      email: emailController.text,
                      profilePictureUrl: _image != null ? _image!.path : "", // إذا تم اختيار صورة، أضف مسار الصورة
                      age: selectedAge != null ? int.parse(selectedAge!) : 0,
                      disabilityTypes: selectedDisabilityType != null ? [selectedDisabilityType!] : [],
                    );
                    context.read<ProfileCubit>().updateUserProfile(entity);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(AppLocalizations.of(context).saveChanges, style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;

  const DropdownField({
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
