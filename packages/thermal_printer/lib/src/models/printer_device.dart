class PrinterDevice {
  final String name;
  final String address;
  final int type;
  final bool isConnected;

  const PrinterDevice({
    required this.name,
    required this.address,
    this.type = 0,
    this.isConnected = false,
  });

  @override
  String toString() => '$name ($address)';
}
