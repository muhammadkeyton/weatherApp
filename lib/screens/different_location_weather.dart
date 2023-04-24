import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DifferentLocationWeather extends StatefulWidget {
  const DifferentLocationWeather({super.key});

  @override
  State<DifferentLocationWeather> createState() => _DifferentLocationWeatherState();
}

class _DifferentLocationWeatherState extends State<DifferentLocationWeather> {

  late String locationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/loading.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide.none),
                        hintText: 'enter city name',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(FontAwesomeIcons.city, color: Colors.white),
                        constraints: BoxConstraints.tightFor(width: 300)),
                    onChanged: (text){
                      setState((){
                        locationName = text;
                      });
                    },
                  ),
                ]),
                const SizedBox(height: 20.0,),
            TextButton(
              onPressed: () {
                 Navigator.pop(context,locationName);
              },
             
              style: const ButtonStyle(
                backgroundColor:MaterialStatePropertyAll(Colors.green),
                padding: MaterialStatePropertyAll(EdgeInsets.all(15.0)),
              ),

              child: const Text('Get Weather info',style: TextStyle(color:Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
