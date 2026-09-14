class ExternalWeather {
  final String cityName;
  final double temp;
  final String desc;

  const ExternalWeather({
    required this.cityName,
    required this.temp,
    required this.desc,
  });

  @override
  String toString() =>
      'ExternalWeather(cityName: $cityName, temp: $temp, desc: $desc)';
}
