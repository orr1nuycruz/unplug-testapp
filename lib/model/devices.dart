class DeviceList {
  String name;
  String deviceType;
  double kwhConsumption;
  double kwhSaved;
  double c02eSaved;
  double savings;
  bool status;

  DeviceList(this.name, this.deviceType, this.kwhConsumption, this.kwhSaved, this.c02eSaved,
      this.savings, this.status);

  static List<DeviceList> getDeviceList() => [
        DeviceList("PS4", "Game Console", 0.089, 0.150, 6.91, 20, true),
        DeviceList("Living Room A/C", "Appliance", 15, 20.14, 6.91, 21, true),
        DeviceList("Lamp", "Appliance", 0.100, 0.125, 3.91, 2, false),
        DeviceList("Tazer", "Tool", 15, 20.14, 6.91, 21, false),
      ];
}
