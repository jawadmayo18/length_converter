import 'package:flutter/material.dart';

void main() {
  runApp(LengthConverterApp());
}

class LengthConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Length Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LengthConverterScreen(),
    );
  }
}

class LengthConverterScreen extends StatefulWidget {
  @override
  _LengthConverterScreenState createState() => _LengthConverterScreenState();
}

class _LengthConverterScreenState extends State<LengthConverterScreen> {
  final TextEditingController _lengthController = TextEditingController();
  double _convertedLength = 0.0;

  // Length conversion rates (relative to meters)
  final Map<String, double> lengthUnits = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Feet': 3.28084,
    'Inches': 39.3701,
    'Yards': 1.09361,
    'Miles': 0.000621371,
  };

  String _fromUnit = 'Meters';
  String _toUnit = 'Kilometers';

  void _convertLength() {
    double length = double.tryParse(_lengthController.text) ?? 0.0;
    double fromRate = lengthUnits[_fromUnit]!;
    double toRate = lengthUnits[_toUnit]!;

    setState(() {
      _convertedLength = (length / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("Length Converter"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _lengthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Length",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton<String>(
                          value: _fromUnit,
                          onChanged: (value) {
                            setState(() {
                              _fromUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: lengthUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),

                        Icon(Icons.arrow_forward, color: Colors.blueAccent),

                        DropdownButton<String>(
                          value: _toUnit,
                          onChanged: (value) {
                            setState(() {
                              _toUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: lengthUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: _convertLength,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Convert",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Converted Length Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.blueAccent,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Converted Length: ${_convertedLength.toStringAsFixed(4)} $_toUnit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
