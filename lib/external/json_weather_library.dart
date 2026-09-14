import 'dart:convert';
import '../models/external_weather.dart';

class JsonWeatherLibrary {
  ExternalWeather parseJsonWeather(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ExternalWeather(
      cityName: json['cityName'] as String,
      temp: (json['temp'] as num).toDouble(),
      desc: json['desc'] as String,
    );
  }
}
