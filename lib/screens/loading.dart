

import 'package:flutter/material.dart';
import 'package:weather/services/weather.dart';

//utilities
import 'package:weather/utilities/network_location_errorcheck.dart';



//weather screen
import 'package:weather/screens/current_location_weather.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  NetworkLocationErrorCheck? networkLocationErrorCheck;

  Widget? Ui;
  
  @override
  void initState() {
    super.initState();

    networkLocationErrorCheck  = NetworkLocationErrorCheck(updateUi: (){updateUi();});
    updateUi();

    
    
  }

  Future<void> startLocationNetworkGetWeather()async {
    

    dynamic coordinates = await networkLocationErrorCheck!.requestLocationNetwork();
    
    if(coordinates != false){
      var currentWeatherData = await Weather(lat:coordinates['latitude'],lon:coordinates['longitude']).getMyCurrentLocationWeather();
      

       

       if(context.mounted){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CurrentLocationWeather(weatherData: currentWeatherData)),
        );
       }
       



    }
    

    

    
  


  }

  

  void updateUi(){
  
    setState(() {
      Ui = networkLocationErrorCheck!.displayLoadingInfo();
    });

    startLocationNetworkGetWeather();
    
  }

  
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
            child: Center(
              child:Ui
            )));
  }
}


