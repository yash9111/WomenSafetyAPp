// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:women_safety_app/Api%20Services/checkLogin.dart';
import 'package:women_safety_app/Screens/askdetails.dart';
import 'package:women_safety_app/Widgets/tabNavigation.dart';
import 'homeScreen.dart';
import 'regristrationScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: <Widget>[
              Text(
                "Rakshikha",
                style: TextStyle(
                    fontSize: height / 19, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/loginimg.jpg',
                height: height * 0.27,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.05, left: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.phone_android)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Positioned(
                        right: 10,
                        child: GestureDetector(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * .02),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            // handleloginuser()
                            showLoder();
                            if (await (checkLogin(
                                emailController.text.toString(),
                                passwordController.text.toString()))) {
                              hideLoder();
                              Fluttertoast.showToast(msg: 'Login Succesful');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const tabNavigation()));
                            } else {
                              hideLoder();
                              Fluttertoast.showToast(msg: "Wrong Credentials");
                            }
                          },
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
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: height * 0.038,
                                    fontWeight: FontWeight.bold),
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
                                    builder: (context) => const Askdetails()));
                          },
                          child: SizedBox(
                            height: height * 0.05,
                            width: width * 1.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_rounded,
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

  void showLoder() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoder() {
    Navigator.of(context).pop();
  }
}
