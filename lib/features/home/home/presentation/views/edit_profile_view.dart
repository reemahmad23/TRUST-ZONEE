import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trust_zone/core/localization/app_localizations.dart';
import 'package:trust_zone/features/home/home/presentation/manager/picture_cubit/picture_cubit.dart';
import 'package:trust_zone/features/home/home/presentation/manager/picture_cubit/picture_state.dart';
import 'package:trust_zone/utils/token_helper.dart';

import '../../domain/entities/update_profile_entity.dart';
import '../manager/profile_cubit/profile_cubit.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String? selectedAge;
  String? selectedDisabilityType;
  Uint8List? _webImageBytes;

  File? _imageFile;
  XFile? _webImageFile;
  String? uploadedImageUrl;

  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().userProfile;
    if (profile != null) {
      nameController.text = profile.userName ?? '';
      emailController.text = profile.email ?? '';
      selectedAge = profile.age.toString();
      selectedDisabilityType = profile.disabilityTypes.isNotEmpty
          ? profile.disabilityTypes.first
          : null;
      uploadedImageUrl = profile.profilePictureUrl;
    }
  }

  Future<String?> _getSasUploadUrl() async {
    final response = await http.get(
      Uri.parse(
          'https://trustzone.azurewebsites.net/api/UserProfile/generateProfilePictureUploadSas'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get upload URL')),
      );
      return null;
    }
  }

  Future<bool> _uploadImageToAzure(String uploadUrl, Uint8List bytes) async {
    final response = await http.put(
      Uri.parse(uploadUrl),
      headers: {
        'x-ms-blob-type': 'BlockBlob',
        'Content-Type': 'image/jpeg',
      },
      body: bytes,
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<void> _notifyBackendWithFileName(String sasUrl) async {
    try {
      final token = await TokenHelper.getToken();
      final fileName = Uri.parse(sasUrl).pathSegments.last.split('?').first;

      final response = await http.put(
        Uri.parse(
            'https://trustzone.azurewebsites.net/api/UserProfile/ProfilePicture/$fileName'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      print('❌ Error notifying backend: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      Uint8List? imageBytes;

      if (kIsWeb) {
        imageBytes = await pickedFile.readAsBytes();
        setState(() {
          _webImageFile = pickedFile;
          _webImageBytes = imageBytes;
        });
      } else {
        _imageFile = File(pickedFile.path);
        imageBytes = await _imageFile!.readAsBytes();
      }

      final sasUrl = await _getSasUploadUrl();

      if (sasUrl == null) {
        setState(() {
          _isUploading = false;
        });
        return;
      }

      final uploadSuccess = await _uploadImageToAzure(sasUrl, imageBytes!);

      if (!uploadSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image to server')),
        );
        setState(() {
          _isUploading = false;
        });
        return;
      }

      await _notifyBackendWithFileName(sasUrl);

      final imageUrl = sasUrl.split('?').first;

      setState(() {
        uploadedImageUrl = imageUrl;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  void _saveProfile() {
    final entity = UpdateProfileEntity(
      userName: nameController.text,
      email: emailController.text,
      profilePictureUrl: uploadedImageUrl ?? '',
      age: selectedAge != null ? int.parse(selectedAge!) : 0,
      disabilityTypes:
          selectedDisabilityType != null ? [selectedDisabilityType!] : [],
    );

    context.read<ProfileCubit>().updateUserProfile(entity);
    Navigator.pop(context, uploadedImageUrl);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (kIsWeb) {
      if (_webImageBytes != null) {
        imageProvider = MemoryImage(_webImageBytes!);
      } else if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
        imageProvider = NetworkImage(uploadedImageUrl!);
      }
    } else {
      if (_imageFile != null) {
        imageProvider = FileImage(_imageFile!);
      } else if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
        imageProvider = NetworkImage(uploadedImageUrl!);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title:
             Text(AppLocalizations.of(context).editProfile, style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdated) {
                context
                    .read<ProfileCubit>()
                    .fetchUserProfile();
                if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
                  setState(() {
                  });
                }

                Navigator.pop(context, uploadedImageUrl);
              } else if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
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
                      backgroundImage: imageProvider,
                      child: imageProvider == null
                          ? const Icon(Icons.person,
                              size: 60, color: Colors.white)
                          : null,
                    ),
                    if (!_isUploading)
                      IconButton(
                        icon: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 24),
                        onPressed: _pickImage,
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(controller: nameController, label: 'Username'),
                CustomTextField(controller: emailController, label: 'Email'),
                DropdownField(
                  label: 'Age',
                  value: selectedAge,
                  items: List.generate(100, (index) => (index + 1).toString()),
                  onChanged: (val) => setState(() => selectedAge = val),
                ),
                DropdownField(
                  label: AppLocalizations.of(context).disabilityType,
                  value: selectedDisabilityType,
                  items: [AppLocalizations.of(context).visual, AppLocalizations.of(context).hearing, AppLocalizations.of(context).mobility, AppLocalizations.of(context).neurological],
                  onChanged: (val) =>
                      setState(() => selectedDisabilityType = val),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[100],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child:  Text(AppLocalizations.of(context).saveChanges,
                      style: TextStyle(color: Colors.black)),
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
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}



