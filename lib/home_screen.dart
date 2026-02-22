import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'services/sensor_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SensorService _sensorService = SensorService();
  bool _isTracking = false; // Track if user has clicked "Start"
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sensor Counter")),
      body: Center(
        child: !_isTracking 
          ? ElevatedButton(
              onPressed: () => setState(() => _isTracking = true),
              child: const Text("Enable Sensors & Start"),
            )
          : StreamBuilder<AccelerometerEvent>(
              stream: _sensorService.accelerometerEvents,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                if (snapshot.hasData) {
                  // Basic shake/tilt logic
                  if (snapshot.data!.x.abs() > 12) {
                    _counter++;
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("X: ${snapshot.data!.x.toStringAsFixed(2)}"),
                      const SizedBox(height: 20),
                      const Text("Counter:", style: TextStyle(fontSize: 20)),
                      Text("$_counter", style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
      ),
    );
  }
}