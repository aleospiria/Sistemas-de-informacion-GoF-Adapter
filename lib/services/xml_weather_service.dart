class XmlWeatherService {
  final Map<String, Map<String, String>> _mockData = {
    'Bogota': {'temp': '18', 'condition': 'Nublado'},
    'Madrid': {'temp': '25', 'condition': 'Soleado'},
    'Tokio': {'temp': '22', 'condition': 'Lluvioso'},
  };

  String getXmlWeather(String city) {
    final data = _mockData[city];
    if (data == null) {
      return '''
      <weather>
        <city>$city</city>
        <temp>0</temp>
        <condition>Sin datos</condition>
      </weather>''';
    }

    return '''
    <weather>
      <city>$city</city>
      <temp>${data['temp']}</temp>
      <condition>${data['condition']}</condition>
    </weather>''';
  }
}
