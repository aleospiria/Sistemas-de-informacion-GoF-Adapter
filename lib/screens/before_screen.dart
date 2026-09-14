import 'package:flutter/material.dart';
import '../services/xml_weather_service.dart';
import '../external/json_weather_library.dart';

class BeforeScreen extends StatefulWidget {
  const BeforeScreen({super.key});

  @override
  State<BeforeScreen> createState() => _BeforeScreenState();
}

class _BeforeScreenState extends State<BeforeScreen> {
  final _xmlService = XmlWeatherService();
  final _jsonLibrary = JsonWeatherLibrary();
  final _cities = ['Bogota', 'Madrid', 'Tokio'];
  String? _errorMessage;
  String? _errorDetail;
  bool _hasError = false;

  void _tryDirectConversion(String city) {
    setState(() {
      _hasError = false;
      _errorMessage = null;
      _errorDetail = null;
    });

    try {
      final String xmlString = _xmlService.getXmlWeather(city);

      _jsonLibrary.parseJsonWeather(xmlString);

      setState(() {
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Error de tipo: XmlWeatherService no es compatible con JsonWeatherLibrary';
        _errorDetail = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
        title: const Text('Sin Adaptador'),
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
                color: const Color(0xFFDC2626).withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDC2626).withValues(alpha:0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Problema:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'El cliente intenta pasar datos XML directamente a una libreria que solo acepta JSON. Los formatos son incompatibles.',
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
                  onPressed: () => _tryDirectConversion(city),
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
            if (_hasError) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFDC2626).withValues(alpha:0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDC2626).withValues(alpha:0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.error, color: Color(0xFFDC2626), size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Error',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDC2626),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage ?? '',
                      style: const TextStyle(color: Color(0xFF1E1B4B), fontSize: 14),
                    ),
                    if (_errorDetail != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1B4B).withValues(alpha:0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorDetail!,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
