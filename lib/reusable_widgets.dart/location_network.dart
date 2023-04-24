import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LocationNetworkInfo extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback callBack;
  const LocationNetworkInfo({super.key,required this.message,required this.callBack,required this.buttonText});
 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left:15.0,right:15.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            const Icon(FontAwesomeIcons.triangleExclamation,color: Colors.red,),
            const SizedBox(height:30),
            Text(message,style:const TextStyle(color:Colors.black)),
            const SizedBox(height:30),
            TextButton(onPressed: callBack,child: Text(buttonText))
          ],
        ),
      ),
    );
  }
}