import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// Import the file where UserData class is defined

Future<bool> registerUser(BuildContext context, String username, String email,
    String phNumber, String password) async {
  final String url = 'https://yogserver.onrender.com/auth/register';

  final Map<String, dynamic> data = {
    "username": email,
    "password": password,
    "firstName": username,
    "lastName": "mmm",
    "gender": "mmm",
    "age": phNumber,
    "weight": 55,
    "height": 5,
    "disease": "mm",
    "profession": "mm",
    "goal": "mm",
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      // Registration successful
      print('Registration successful');
      return true;
      // Handle success appropriately, e.g., navigate to another screen
    } else {
      // Registration failed
      print('Registration failed. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      // Handle error appropriately
    }
  } catch (error) {
    print('Error during registration: $error');
    // Handle error appropriately
  }
  return false;
}
