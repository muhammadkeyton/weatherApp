import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Location {
  double? latitude;
  double? longitude;
  

  Future<dynamic> getCurrentLocationCheckConnectionFailed() async {
    bool serviceEnabled;
    LocationPermission permission;

    //check internet connection
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
       return [
        {'message': 'no internet connection on this device,please enable wifi or cellular data and tap ok again to continue'},
        {'errorType': 'noNetwork'},
        {'failed':true},
        {'buttonText':'OK'}
      ];
    } 

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();

      return [
        {'message': 'Location is not turned on this device,tap get my location and turn on location and tap get my location again to continue'},
        {'errorType': 'locationDisabled'},
        {'failed':true},
        {'buttonText':'get my location'}
      ];
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return [
          {'message': 'you need to give us permission to access your location,tap give permission and allow permissions and tap give permission again to continue'},
          {'errorType': 'permissionNotGranted'},
          {'failed':true},
          {'buttonText':'give permission'}
        ];
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately,we cannot request permissions,user has to grant manually
      
      await Geolocator.openAppSettings();
      return [
        {
          'message':
              'we can\'t access your location,tap check app setting to go to the app settings,give us location permission and tap check app setting again to continue'
        },
        {'errorType': 'permissionDeniedForever'},

        {'failed':true},
        {'buttonText':'check app setting'}
      ];
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    latitude = position.latitude;
    longitude = position.longitude;

    return [{},{},{'failed':false},{}];
  }
}
