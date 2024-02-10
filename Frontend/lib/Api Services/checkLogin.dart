import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> checkLogin(String username, String password) async {
  final String url = 'https://yogserver.onrender.com/auth/login';

  final Map<String, dynamic> data = {
    "username": username,
    "password": password,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Login successful
      Map<String, dynamic> responseBody = json.decode(response.body);
      String token = responseBody['token'];

      // Do something with the token, e.g., store it for future API requests
      print('Login successful. Token: $token');
      return true;
    } else {
      // Login failed
      print('Login failed. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      // Handle error appropriately
    }
  } catch (error) {
    print('Error during login: $error');
    // Handle error appropriately
  }
  return false;
}
