enum VehicleStatus {
  active, // 0
  inactive, // 1
}

extension VehicleStatusExtension on VehicleStatus {
  static const Map<VehicleStatus, int> _values = {
    VehicleStatus.active: 0,
    VehicleStatus.inactive: 1,
  };

  static Map<int, VehicleStatus> _reverseValues = {
    for (var entry in _values.entries) entry.value: entry.key
  };

  int get value => _values[this]!;

  static VehicleStatus fromValue(int value) => _reverseValues[value]!;
}
