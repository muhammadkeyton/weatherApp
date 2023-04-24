

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//services
import 'package:weather/services/location.dart';


//reuseable widgets
import 'package:weather/reusable_widgets.dart/location_network.dart';


class NetworkLocationErrorCheck{

  NetworkLocationErrorCheck({required this.updateUi,this.currentLocationPage});
  
  bool? currentLocationPage;
  void Function() updateUi;
  Location location = Location();
  List locationDisabled = <Map>[{},{},{'failed':false},{}];
  List permissionNotGranted = <Map>[{},{},{'failed':false},{}];
  List permissionDeniedForever = <Map>[{},{},{'failed':false},{}];
  List noNetwork = <Map>[{},{},{'failed':false},{}];
  


  

  //this method invokes a method in the location object that checks network,location services and location access permission and returns
  //the location coordinates or the problems encountered
  Future<dynamic> requestLocationNetwork() async {
    var responseFailed = await location.getCurrentLocationCheckConnectionFailed();
    // print(locationResponse);
    if (!responseFailed[2]['failed']) {


      //reset values to default if response was successfull
      locationDisabled = <Map>[{},{},{'failed':false},{}];
      permissionNotGranted = <Map>[{},{},{'failed':false},{}];
      permissionDeniedForever = <Map>[{},{},{'failed':false},{}];
      noNetwork = <Map>[{},{},{'failed':false},{}];
      
      //get current location weather info here and return it
      return {'latitude':location.latitude,'longitude':location.longitude};

      


    } else {
      
      
      if (responseFailed[1]['errorType'] == 'locationDisabled')locationDisabled =  responseFailed;
      if (responseFailed[1]['errorType'] == 'permissionNotGranted')permissionNotGranted =  responseFailed;
      if (responseFailed[1]['errorType'] == 'permissionDeniedForever')permissionDeniedForever =  responseFailed;
      if (responseFailed[1]['errorType'] == 'noNetwork') noNetwork =  responseFailed;
      

      
      return false;
    }
  }


   
   //this method displays a widget that shows the type of problem,whether unavailable network or no permissions to access location or no location service
   dynamic displayLoadingInfo(){

    if(locationDisabled[2]['failed']) {

     

     return LocationNetworkInfo(message:locationDisabled[0]['message'] ,buttonText: locationDisabled[3]['buttonText'],callBack:()async{
      
      await requestLocationNetwork();
      updateUi();


     },);
    }

    if(permissionNotGranted[2]['failed']) {
    
     return LocationNetworkInfo(message:permissionNotGranted[0]['message'] ,buttonText: permissionNotGranted[3]['buttonText'],callBack: ()async{
      await requestLocationNetwork();
      updateUi();
     },);
    }

    if(permissionDeniedForever[2]['failed']) {
    
      return LocationNetworkInfo(message:permissionDeniedForever[0]['message'] ,buttonText: permissionDeniedForever[3]['buttonText'],callBack: ()async{
        await requestLocationNetwork();
        updateUi();
      },);
    }

    if(noNetwork[2]['failed']){
      
      return  LocationNetworkInfo(message:noNetwork[0]['message'] ,buttonText: noNetwork[3]['buttonText'],
      callBack: ()async{
        await requestLocationNetwork();
        updateUi();
      }

    ,);}


    

   

    if(currentLocationPage == false || currentLocationPage == null) {
      return SpinKitCubeGrid(color: Colors.green.shade200,size: 100.0);
    }else{
      return true;
    }
  
      
    
  }


}