import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/category_model/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategoryById(int id);
  Future<void> addCategory(String name);
  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  //final String token;

  static const _baseUrl = "https://trustzone.azurewebsites.net/api/Category";
  static const _headers = {
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkb25pYTEyMyIsImp0aSI6IjJmNWI2MjJkLWRjNWQtNDBlZS1hZTUwLWYxMDgzOWNkNmMxNiIsIlVpZCI6IjU3NTBhNWNhLWQ4MDctNGExMC04ZDYwLTc1NDg2NmZjODcyZCIsInJvbGVzIjoiVXNlciIsImV4cCI6MTc0Nzg1Mzc4OCwiaXNzIjoiVHJ1c3Rab25lIiwiYXVkIjoiVHJ1c3Rab25lVXNlciJ9.2VzM558dhp7-ia_o3v2FevStIPg8_8hHybK2kmjDiJk',
    'accept': '*/*',
    'Content-Type': 'application/json',
  };

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse("https://trustzone.azurewebsites.net/api/Category"),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkb25pYTEyMyIsImp0aSI6IjJmNWI2MjJkLWRjNWQtNDBlZS1hZTUwLWYxMDgzOWNkNmMxNiIsIlVpZCI6IjU3NTBhNWNhLWQ4MDctNGExMC04ZDYwLTc1NDg2NmZjODcyZCIsInJvbGVzIjoiVXNlciIsImV4cCI6MTc0Nzg1Mzc4OCwiaXNzIjoiVHJ1c3Rab25lIiwiYXVkIjoiVHJ1c3Rab25lVXNlciJ9.2VzM558dhp7-ia_o3v2FevStIPg8_8hHybK2kmjDiJk',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"), headers: _headers);

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load category by ID");
    }
  }

  @override
  Future<void> addCategory(String name) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: _headers,
      body: jsonEncode({"name": name}),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Failed to add category");
    }
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    final response = await http.put(
      Uri.parse("$_baseUrl/$id"),
      headers: _headers,
      body: jsonEncode({"name": name}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update category");
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    final response = await http.delete(
      Uri.parse("$_baseUrl/$id"),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete category");
    }
  }
}
