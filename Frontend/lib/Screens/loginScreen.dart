// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'homeScreen.dart';
import 'regristrationScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void handleloginuser() async {
      Map<String, dynamic> request = {
        "phone_number": phoneNumberController.toString(),
        "password": passwordController.toString()
      };
      final uri = Uri.parse("http://127.0.0.1:8000/loginuser/");

      try {
        final response = await http.post(uri, body: request);

        if (response.statusCode == 302) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else if (response.statusCode == 404) {
          print("not found");
        } else {
          print("not ok");
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: <Widget>[
              Text(
                "Rakshikha",
                style: TextStyle(
                    fontSize: height / 15, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/loginimg.png',
                height: height * 0.35,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.phone_android)),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: passwordController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: GestureDetector(
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => {handleloginuser()},
                          child: Container(
                            height: height * 0.07,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.pink.shade400,
                                  Colors.yellow.shade800
                                ]),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.purpleAccent,
                                      offset: Offset(2, 2))
                                ]),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: Container(
                            height: height * 0.07,
                            width: width * 1.8,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Colors.orange),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
