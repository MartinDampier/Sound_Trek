enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class WeatherHandler{

  String _apikey = "2d8eecd0e64982c96fe8325e68c040c7";

  static WeatherCondition mapStringToWeatherCondition(String input, int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'fog':
        condition = WeatherCondition.fog;
        break;
      default:
        condition = WeatherCondition.unknown;
    }
    return condition;
  }

}