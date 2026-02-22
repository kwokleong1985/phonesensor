import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  // We expose the stream so the UI can "listen" to it
  Stream<AccelerometerEvent> get accelerometerEvents => accelerometerEventStream();
}