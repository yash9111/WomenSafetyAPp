// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:women_safety_app/Widgets/tabNavigation.dart';
import 'homeScreen.dart';
import 'regristrationScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void handleloginuser() async {
      Map<String, dynamic> request = {
        "phone_number": phoneNumberController.text,
        "password": passwordController.text
      };
      final uri = Uri.parse("http://10.0.2.2:8000/loginuser/");

      try {
        final response = await http.post(uri, body: request);

        if (response.statusCode == 302) {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
          print("done");
        } else if (response.statusCode == 404) {
          print("not found");
        } else {
          print("error");
        }
      } catch (e) {
        AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    }

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
                    fontSize: height / 15, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/loginimg.jpg',
                height: height * 0.34,
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
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
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
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.57),
                        child: GestureDetector(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.02),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => {
                            // handleloginuser()
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const tabNavigation()))
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
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: SizedBox(
                            height: height * 0.07,
                            width: width * 1.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontSize: height * 0.035,
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
}
