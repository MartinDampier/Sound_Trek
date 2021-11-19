class WeatherReport {
  final List<dynamic> weather;
  //final double windSpeed;

  WeatherReport({
    required this.weather,
    //required this.windSpeed,
  });

  factory WeatherReport.fromJson(Map<String, dynamic> json) {
    return WeatherReport(
        weather: json['weather'],
        //windSpeed: json['speed']
    );
  }
}