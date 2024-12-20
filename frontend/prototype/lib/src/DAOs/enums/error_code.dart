enum ErrorCode {
  noErr,
  battOverDischarge,
  battOverVoltage,
  battUnderVoltage,
  loadShortCircuit,
  loadOverPower,
  ctrlTempHigh,
  battTemptHigh,
  pvInOverPower,
  pvInOverVolt,
  pvMpptOverVolt,
  pvRevPol,
  battChargeProtection,
  battRevPolarity,
}

extension ErrorCodeExtension on ErrorCode {
  static const Map<ErrorCode, int> _values = {
    ErrorCode.noErr: 0,
    ErrorCode.battOverDischarge: 1,
    ErrorCode.battOverVoltage: 2,
    ErrorCode.battUnderVoltage: 4,
    ErrorCode.loadShortCircuit: 8,
    ErrorCode.loadOverPower: 16,
    ErrorCode.ctrlTempHigh: 32,
    ErrorCode.battTemptHigh: 64,
    ErrorCode.pvInOverPower: 128,
    ErrorCode.pvInOverVolt: 512,
    ErrorCode.pvMpptOverVolt: 2048,
    ErrorCode.pvRevPol: 4096,
    ErrorCode.battChargeProtection: 67108864,
    ErrorCode.battRevPolarity: 268435456,
  };

  static final Map<int, ErrorCode> _reverseValues = {
    for (var entry in _values.entries) entry.value: entry.key
  };

  int get value => _values[this]!;

  static ErrorCode fromValue(int value) => _reverseValues[value]!;
}
