import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiRequestHelper{

  ApiRequestHelper({required this.url,required this.requestQuery,required this.endPoint});

  String url;
  String endPoint;
  Map<String,dynamic> requestQuery;


  Future<dynamic> sendRequest()async{
    var reqData = Uri.https(url,endPoint,requestQuery);

    http.Response response = await http.get(reqData);

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }

    return {'message':'request failed'};
  }


}