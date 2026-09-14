import 'dart:convert';
import 'package:xml/xml.dart';

import '../models/weather_data.dart';
import '../services/weather_service.dart';
import '../services/xml_weather_service.dart';
import '../external/json_weather_library.dart';

class XmlToJsonAdapter implements WeatherService {
  final XmlWeatherService _xmlService;
  final JsonWeatherLibrary _jsonLibrary;

  XmlToJsonAdapter({
    XmlWeatherService? xmlService,
    JsonWeatherLibrary? jsonLibrary,
  })  : _xmlService = xmlService ?? XmlWeatherService(),
        _jsonLibrary = jsonLibrary ?? JsonWeatherLibrary();

  @override
  Future<WeatherData> getWeather(String city) async {
    final String xmlString = _xmlService.getXmlWeather(city);

    final String jsonString = _convertXmlToJson(xmlString);

    final externalWeather = _jsonLibrary.parseJsonWeather(jsonString);

    return WeatherData(
      city: externalWeather.cityName,
      temperature: externalWeather.temp,
      condition: externalWeather.desc,
    );
  }

  String _convertXmlToJson(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final root = document.rootElement;

    final city = root.findElements('city').first.innerText;
    final temp = root.findElements('temp').first.innerText;
    final condition = root.findElements('condition').first.innerText;

    return jsonEncode({
      'cityName': city,
      'temp': double.tryParse(temp) ?? 0,
      'desc': condition,
    });
  }
}
