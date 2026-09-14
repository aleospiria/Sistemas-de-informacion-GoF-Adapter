class WeatherData {
  final String city;
  final double temperature;
  final String condition;

  const WeatherData({
    required this.city,
    required this.temperature,
    required this.condition,
  });

  @override
  String toString() =>
      'WeatherData(city: $city, temperature: $temperature, condition: $condition)';
}
