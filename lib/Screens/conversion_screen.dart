import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String _selectedCategory = 'Mata Uang';

  double _inputValue = 0.0;
  double _resultValue = 0.0;
  String _selectedInputUnit = '';
  String _selectedOutputUnit = '';
  String _resultUnit = '';

  final Map<String, List<String>> _unitOptions = {
    'Mata Uang': ['IDR', 'USD', 'EUR'],
    'Suhu': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Berat': ['Kilogram', 'Pound', 'Gram'],
  };

  void _convert() {
    switch (_selectedCategory) {
      case 'Mata Uang':
        _resultValue = _convertCurrency(_inputValue, _selectedInputUnit, _selectedOutputUnit);
        break;
      case 'Suhu':
        _resultValue = _convertTemperature(_inputValue, _selectedInputUnit, _selectedOutputUnit);
        break;
      case 'Berat':
        _resultValue = _convertWeight(_inputValue, _selectedInputUnit, _selectedOutputUnit);
        break;
    }
    setState(() {});
  }

  double _convertCurrency(double value, String from, String to) {
    const rates = {
      'IDR': {'USD': 1 / 16000, 'EUR': 1 / 17000},
      'USD': {'IDR': 16000, 'EUR': 0.94},
      'EUR': {'IDR': 17000, 'USD': 1.06},
    };

    _resultUnit = to;
    if (from == to) return value;
    return (value * (rates[from]?[to] ?? 1.0)).roundToDouble();
  }

  double _convertTemperature(double value, String from, String to) {
    if (from == to) return value;
    if (from == 'Celsius' && to == 'Fahrenheit') return (value * 9 / 5) + 32;
    if (from == 'Celsius' && to == 'Kelvin') return value + 273.15;
    if (from == 'Fahrenheit' && to == 'Celsius') return (value - 32) * 5 / 9;
    if (from == 'Fahrenheit' && to == 'Kelvin') return ((value - 32) * 5 / 9) + 273.15;
    if (from == 'Kelvin' && to == 'Celsius') return value - 273.15;
    if (from == 'Kelvin' && to == 'Fahrenheit') return ((value - 273.15) * 9 / 5) + 32;
    return value;
  }

  double _convertWeight(double value, String from, String to) {
    const rates = {
      'Kilogram': {'Pound': 2.20462, 'Gram': 1000},
      'Pound': {'Kilogram': 0.453592, 'Gram': 453.592},
      'Gram': {'Kilogram': 0.001, 'Pound': 0.00220462},
    };

    _resultUnit = to;
    if (from == to) return value;
    return (value * (rates[from]?[to] ?? 1.0)).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedCategory,
              items: _unitOptions.keys
                  .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                  _selectedInputUnit = '';
                  _selectedOutputUnit = '';
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Input Value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _inputValue = double.tryParse(value) ?? 0.0;
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedInputUnit.isNotEmpty ? _selectedInputUnit : null,
                  hint: Text('Input Unit'),
                  items: _unitOptions[_selectedCategory]!
                      .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedInputUnit = value!;
                    });
                  },
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _selectedOutputUnit.isNotEmpty ? _selectedOutputUnit : null,
                  hint: Text('Output Unit'),
                  items: _unitOptions[_selectedCategory]!
                      .map((unit) => DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOutputUnit = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(
              'Result: ${_resultValue.toStringAsFixed(0)} $_resultUnit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
