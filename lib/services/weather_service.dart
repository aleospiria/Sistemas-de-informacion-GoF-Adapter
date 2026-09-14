import '../models/weather_data.dart';

abstract class WeatherService {
  Future<WeatherData> getWeather(String city);
}
