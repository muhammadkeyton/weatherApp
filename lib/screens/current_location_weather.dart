import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//utilities
import 'package:weather/utilities/constants.dart';
import 'package:weather/utilities/network_location_errorcheck.dart';

//screen
import 'package:weather/screens/different_location_weather.dart';

//services
import 'package:weather/services/weather.dart';


class CurrentLocationWeather extends StatefulWidget {
  const CurrentLocationWeather({super.key, required this.weatherData});

  final dynamic weatherData;

  @override
  State<CurrentLocationWeather> createState() => _CurrentLocationWeatherState();
}

class _CurrentLocationWeatherState extends State<CurrentLocationWeather> {
  late String locationName;
  late int temperature;
  late String description;
  late int visibility;
  late int humidity;
  late int windSpeed;
  late int weatherCondition;

  @override
  void initState() {
    super.initState();
    locationName = widget.weatherData['name'];
    temperature = widget.weatherData['main']['temp'].toInt();
    description = widget.weatherData['weather'][0]['description'];
    visibility = (widget.weatherData['visibility'] / 1000).toInt();
    humidity = widget.weatherData['main']['humidity'];
    windSpeed = widget.weatherData['wind']['speed'].toInt();
    weatherCondition = widget.weatherData['weather'][0]['id'];
  }



  Future<void> startLocationNetworkGetWeather()async {
    

    dynamic coordinates = await NetworkLocationErrorCheck(updateUi:(){updateCurrentLocationUi();},currentLocationPage: true).requestLocationNetwork();
    
    if(coordinates != false){
      var currentWeatherData = await Weather(lat:coordinates['latitude'],lon:coordinates['longitude']).getMyCurrentLocationWeather();
      
       setState((){
        locationName = currentWeatherData['name'];
        temperature = currentWeatherData['main']['temp'].toInt();
        description = currentWeatherData['weather'][0]['description'];
        visibility = (currentWeatherData['visibility']/1000).toInt();
        humidity = currentWeatherData['main']['humidity'];
        windSpeed = currentWeatherData['wind']['speed'].toInt();
        weatherCondition = currentWeatherData['weather'][0]['id'];

      });

    }
    

    

    
  


  }

  void updateCityUi(cityData) {
    setState((){
      locationName = cityData['name'];
      temperature = cityData['main']['temp'].toInt();
      description = cityData['weather'][0]['description'];
      visibility = (cityData['visibility']/1000).toInt();
      humidity = cityData['main']['humidity'];
      windSpeed = cityData['wind']['speed'].toInt();
      weatherCondition = cityData['weather'][0]['id'];

    });
  }

  void updateCurrentLocationUi(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loading.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            child: const Icon(FontAwesomeIcons.locationDot,
                                color: Colors.white),
                            onPressed: () async{
                              startLocationNetworkGetWeather();
                            },
                          ),
                          TextButton(
                            child: const Icon(FontAwesomeIcons.city,
                                color: Colors.white),
                            onPressed: () async{
                              String cityName = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DifferentLocationWeather()),
                              );

                              

                              var cityData = await Weather(cityName: cityName).getAnotherLocationWeather();
                              
                              updateCityUi(cityData);
                              
                              

                            },
                          ),
                        ]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(locationName.toUpperCase(),
                                style: kLocationName),
                            Text('$temperature°', style: kTemperature),
                          ],
                        ),
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            description,
                            style: kInfo,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(bottom: 15.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          // color:Colors.red,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          )),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Detail(
                              detailNumber: '$humidity%',
                              detailText: 'humidity',
                            ),
                            Detail(
                              detailNumber: '${visibility}km',
                              detailText: 'Visibility',
                            ),
                            Detail(
                              detailNumber: '${windSpeed.toString()}m/s',
                              detailText: 'windSpeed',
                            ),
                          ]),
                    ),
                  ]),
            ),
          )),
    );
  }
}

class Detail extends StatelessWidget {
  final String detailNumber;
  final String detailText;

  const Detail(
      {super.key, required this.detailNumber, required this.detailText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(detailNumber, style: kDetailNumber),
        const SizedBox(
          height: 5,
        ),
        Text(
          detailText,
          style: kDetailText,
        )
      ],
    );
  }
}
