import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../adapters/xml_to_json_adapter.dart';

class AfterScreen extends StatefulWidget {
  const AfterScreen({super.key});

  @override
  State<AfterScreen> createState() => _AfterScreenState();
}

class _AfterScreenState extends State<AfterScreen> {
  final _adapter = XmlToJsonAdapter();
  final _cities = ['Bogota', 'Madrid', 'Tokio'];
  WeatherData? _weatherData;
  bool _isLoading = false;

  Future<void> _loadWeather(String city) async {
    setState(() {
      _isLoading = true;
      _weatherData = null;
    });

    final data = await _adapter.getWeather(city);

    setState(() {
      _weatherData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF059669),
        foregroundColor: Colors.white,
        title: const Text('Con Adaptador'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF059669).withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF059669).withValues(alpha:0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Solucion:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF059669),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'El adaptador traduce XML a JSON, permitiendo que el cliente use la interfaz WeatherService sin conocer la complejidad interna.',
                    style: TextStyle(color: Color(0xFF1E1B4B), fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selecciona una ciudad:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1B4B),
              ),
            ),
            const SizedBox(height: 12),
            ..._cities.map((city) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _loadWeather(city),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1E1B4B),
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    elevation: 0,
                  ),
                  child: Text('Obtener clima de $city'),
                ),
              ),
            )),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Color(0xFF059669)),
              )
            else if (_weatherData != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF059669).withValues(alpha:0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha:0.8),
                      blurRadius: 6,
                      offset: const Offset(-2, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFF97316),
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _weatherData!.city,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_weatherData!.temperature} C',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F46E5).withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _weatherData!.condition,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
