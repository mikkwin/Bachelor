enum ErrorCode {
  NO_ERR,
  BATT_OVER_DISCHARGE,
  BATT_OVER_VOLTAGE,
  BATT_UNDER_VOLTAGE,
  LOAD_SHORT_CIRQUIT,
  LOAD_OVER_POWER,
  CTRL_TEMP_HIGH,
  BATT_TEMP_HIGH,
  PV_IN_OVER_POWER,
  PV_IN_OVER_VOLT,
  PV_MPPT_OVER_VOLT,
  PV_REV_POL,
  BATT_CHARGE_PROTECTION,
  BATT_REV_POLARITY,
}

extension ErrorCodeExtension on ErrorCode {
  static const Map<ErrorCode, int> _values = {
    ErrorCode.NO_ERR: 0,
    ErrorCode.BATT_OVER_DISCHARGE: 1,
    ErrorCode.BATT_OVER_VOLTAGE: 2,
    ErrorCode.BATT_UNDER_VOLTAGE: 4,
    ErrorCode.LOAD_SHORT_CIRQUIT: 8,
    ErrorCode.LOAD_OVER_POWER: 16,
    ErrorCode.CTRL_TEMP_HIGH: 32,
    ErrorCode.BATT_TEMP_HIGH: 64,
    ErrorCode.PV_IN_OVER_POWER: 128,
    ErrorCode.PV_IN_OVER_VOLT: 512,
    ErrorCode.PV_MPPT_OVER_VOLT: 2048,
    ErrorCode.PV_REV_POL: 4096,
    ErrorCode.BATT_CHARGE_PROTECTION: 67108864,
    ErrorCode.BATT_REV_POLARITY: 268435456,
  };

  static Map<int, ErrorCode> _reverseValues = {
    for (var entry in _values.entries) entry.value: entry.key
  };

  int get value => _values[this]!;

  static ErrorCode fromValue(int value) => _reverseValues[value]!;
}
