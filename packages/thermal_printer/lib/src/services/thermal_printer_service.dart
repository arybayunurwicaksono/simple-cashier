import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import '../models/printer_device.dart';

class ThermalPrinterService {
  /// Request Bluetooth permissions required on Android 12+ (BLUETOOTH_SCAN, BLUETOOTH_CONNECT)
  Future<bool> requestPermissions() async {
    final connect = await Permission.bluetoothConnect.request();
    final scan = await Permission.bluetoothScan.request();
    return connect.isGranted && scan.isGranted;
  }

  /// Check if bluetooth is available & turned on
  Future<bool> isBluetoothAvailable() async {
    return await PrintBluetoothThermal.bluetoothEnabled;
  }

  /// Get list of paired / bonded Bluetooth printers
  Future<List<PrinterDevice>> getBondedDevices() async {
    try {
      final List<BluetoothInfo> list = await PrintBluetoothThermal.pairedBluetooths;
      return list.map((d) {
        return PrinterDevice(
          name: d.name.isNotEmpty ? d.name : 'Thermal Printer',
          address: d.macAdress,
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }

  /// Connects to a specific printer device by MAC address
  Future<bool> connect(PrinterDevice device) async {
    try {
      final result = await PrintBluetoothThermal.connect(macPrinterAddress: device.address);
      return result;
    } catch (_) {
      return false;
    }
  }

  /// Disconnects from current printer
  Future<void> disconnect() async {
    try {
      await PrintBluetoothThermal.disconnect;
    } catch (_) {}
  }

  /// Checks current connection status
  Future<bool> isConnected() async {
    try {
      return await PrintBluetoothThermal.connectionStatus;
    } catch (_) {
      return false;
    }
  }

  /// Sends raw ESC/POS byte array to connected printer
  Future<bool> writeBytes(List<int> bytes) async {
    try {
      final connected = await isConnected();
      if (!connected) return false;
      return await PrintBluetoothThermal.writeBytes(bytes);
    } catch (_) {
      return false;
    }
  }
}
