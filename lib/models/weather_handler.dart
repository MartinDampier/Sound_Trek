
import 'package:basic/models/weather_reporter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherHandler{
  //https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=2d8eecd0e64982c96fe8325e68c040c7
  String _apikey = "2d8eecd0e64982c96fe8325e68c040c7";

  String weather = "what";
  List<dynamic> a = List.generate(0, (index) => null);
  WeatherReport report = new WeatherReport(weather: []);


//lat: 30.432277 long -91.186167

  Future<WeatherReport> fetchReport() async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=2d8eecd0e64982c96fe8325e68c040c7'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return WeatherReport.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to weather');
    }
  }

 String getWeather(){
    return "";
  }

  String getSunrise(){
  return "wow";
  }

  String getSunset(){
    return "wow";
  }

  String getWindSpeed(){
    return "wow";
  }

   Future<void> updateReport() async {
     print("started report");
     report = await fetchReport();
     print(report.weather.elementAt(0).toString());
     weather = report.weather.elementAt(0).toString();
     print(weather);
     print("ended report");
  }

}