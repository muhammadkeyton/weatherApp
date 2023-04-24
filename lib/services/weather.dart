
import 'package:weather/utilities/api_request_helper.dart';

class Weather{
  
  Weather({this.lat,this.lon,this.cityName});

  String apiKey = '40d2737e48130f94179a28c2297dbfd9';
  String url = 'api.openweathermap.org';
  String endPoint = '/data/2.5/weather';

  dynamic lat;
  dynamic lon;
  String? cityName;


  Future<dynamic> getMyCurrentLocationWeather()async{
    return await ApiRequestHelper(url: url,endPoint: endPoint, requestQuery: {'lat':'$lat','lon':'$lon','appid':apiKey,'units':'metric'}).sendRequest();
  }

  Future<dynamic> getAnotherLocationWeather()async{
    return await ApiRequestHelper(url:url,endPoint: endPoint,requestQuery: {'q':cityName,'appid':apiKey,'units':'metric'}).sendRequest();
  }



}