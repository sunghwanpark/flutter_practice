import 'dart:convert';

import 'package:bunyang/Data/URL.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

class MyGoogleMapModel
{
  Tuple2<double, double> getLatLng(String body)
  {
    var jsonMap = json.decode(body)["results"];
    var geometry = jsonMap[0]["geometry"];
    var location = geometry["location"];
    var lat = location["lat"];
    var lng = location["lng"];
      
    return Tuple2(lat, lng);
  }
    
  Future<Tuple2<double, double>> fetchGeocode(String addr) async
  {
    String encodeAddress = Uri.encodeComponent(addr);
  
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write("https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address=");
    stringBuffer.write(encodeAddress);
    stringBuffer.write("&key=");
    stringBuffer.write(googleMapApiKey);
  
    return await http.post(stringBuffer.toString())
      .timeout(const Duration(seconds: 5))
      .then((res) => getLatLng(res.body));
  }
}