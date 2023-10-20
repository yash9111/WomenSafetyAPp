import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otpScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController NumberController = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    void sendcrend() async{
      final uri = Uri.parse("http://10.0.2.2:8000/postotp/");
      Map<String ,dynamic> request = {"phone_number":countrycode.text+NumberController.text};
      try{
        final responce = await http.post(uri,body: request);
        
        if (responce.statusCode==200){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>otpScreen()));
        }else{
          print("error 304");
        }
      }
      catch(e){
        print(e.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
             Stack(
               clipBehavior: Clip.none,
                 children:[ Padding(
               padding: const EdgeInsets.only(top:80,left: 200),
               child: Image.asset("assets/images/girlwithphone.png",width: width*0.55),
             ),
               Padding(
                 padding: const EdgeInsets.only(top: 280,left: 0),
                 child: Image.asset("assets/images/chatimg.png",width: width*0.55,),
               ),
                    const Padding(
                     padding: EdgeInsets.only(top: 150,left: 20),
                     child: Text("Signup",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                   )
    ]
             ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: NumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number',border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                    prefixIcon: Icon(Icons.phone_android,color: Colors.blueGrey,)),
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: GestureDetector(
                onTap: ()=>{Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const otpScreen()))
              },

                child: Container(
                height: height*0.07,
                width: width*0.5,
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.pink,Colors.pinkAccent],begin: Alignment.topLeft,end: Alignment.bottomRight),borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [BoxShadow(offset: Offset(2,2),color: Colors.grey,spreadRadius: 3,blurRadius: 5,blurStyle: BlurStyle.inner)]),
                child:const Center(child: Text("Create Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,color: Colors.white70),)),
              ),),
            )
          ],
        ),
      ),
    );

}
}
