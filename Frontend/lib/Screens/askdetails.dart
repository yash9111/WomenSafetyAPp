import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/Api%20Services/registerUser.dart';
import 'package:women_safety_app/Widgets/tabNavigation.dart';
import 'homeScreen.dart';

class Askdetails extends StatefulWidget {
  const Askdetails({super.key});

  @override
  State<Askdetails> createState() => _AskdetailsState();
}

class _AskdetailsState extends State<Askdetails> {
  bool obText = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  "Personal details",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Name',
                      prefixIcon:
                          Icon(Icons.person, color: Colors.pink.shade300)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'email',
                      prefixIcon:
                          Icon(Icons.email_sharp, color: Colors.pink.shade300)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phNoController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_android_outlined,
                        color: Colors.pink.shade300),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passController,
                  obscureText: obText,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Password',
                      prefixIcon:
                          Icon(Icons.password, color: Colors.pink.shade300),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obText = !obText;
                          });
                        },
                        icon: obText
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      )),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    showLoder();
                    if (await registerUser(
                        context,
                        usernameController.text.toString(),
                        emailController.text.toString(),
                        phNoController.text.toString(),
                        passController.text.toString())) {
                      hideLoder();
                      Fluttertoast.showToast(
                          msg: "Welcome ${usernameController.text.toString()}");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const tabNavigation()));
                    } else {
                      hideLoder();
                      Fluttertoast.showToast(msg: "Something went wrong");
                    }
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade200,
                              Colors.pink.shade200
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(2, 2),
                              color: Colors.grey,
                              spreadRadius: 3,
                              blurRadius: 5,
                              blurStyle: BlurStyle.inner)
                        ]),
                    child: const Center(
                        child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )),
                  ),
                )
              ],
            ),
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
