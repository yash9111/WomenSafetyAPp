import 'package:flutter/material.dart';

class Slidingsheet extends StatelessWidget {

  String text;
  String imagePath;
  Function() onTap;
  Slidingsheet({super.key,required this.text,required this.imagePath,required this.onTap});

  @override

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return GestureDetector(onTap: onTap,
      child: Column(
          children: <Widget>[
            CircleAvatar(maxRadius: 50,child:Image.asset(imagePath,height: height*0.2,width:width*0.4),
            ),
            const SizedBox(height: 10,),
            Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            const SizedBox(height: 20,)
          ]
      ),
    );
  }
}
