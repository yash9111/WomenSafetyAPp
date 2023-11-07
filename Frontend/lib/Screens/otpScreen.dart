import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:women_safety_app/Screens/homeScreen.dart';


class otpScreen extends StatefulWidget {
  const otpScreen({super.key});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {

  TextEditingController OtpController = TextEditingController();

  void checkOtp()async{
    final uri = Uri.parse("http://10.0.2.2:8000/checkotp/");
    Map<String,dynamic> request = {'otp':OtpController.text};

    try {
      final responce = await http.post(uri,body: request);
      if(responce.statusCode==200){
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context)=>const Home()),
                (route) => false);
      }
    }catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/otpimg.png",width: width*1.2,height: height*0.3,),

            const SizedBox(height: 70,),
        const Text("Verification",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 60),),
            const SizedBox(height: 10,),

            const Text("Verify yourself by entering the otp",style: TextStyle(fontSize: 15)),

            const SizedBox(height: 20,),

            Padding(
          padding: const EdgeInsets.all(20),
          child: Pinput(
            controller: OtpController,
            pinAnimationType: PinAnimationType.slide,
            length: 6,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          ),
        ),
            const SizedBox(height: 10,),
            const Text("Resend OTP" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text("Change Mobile Number",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            const SizedBox(height: 30,),
            Center(
              child: GestureDetector(
                onTap: ()=>{checkOtp()},
                child: Container(
                  height: height*0.07,
                  width: width*0.5,
                  decoration:  BoxDecoration(gradient: LinearGradient(colors: [Colors.pink.shade200,Colors.pink.shade200],begin: Alignment.topLeft,end: Alignment.bottomRight),borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: const [BoxShadow(offset: Offset(2,2),color: Colors.grey,spreadRadius: 3,blurRadius: 5,blurStyle: BlurStyle.inner)]),
                  child:const Center(child: Text("Create Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,color: Colors.black),)),
                ),),
            )
        ],
        ),
      ),
    );
  }
}
