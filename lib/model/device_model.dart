class DeviceModel {
  String deviceType;
  String deviceId;
  String deviceName;
  String deviceOSVersion;
  String deviceIPAddress;
  double latitude;
  double longitude;
  String buyerGcmId;
  String appVersion;

  DeviceModel({
    required this.deviceType,
    required this.deviceId,
    required this.deviceName,
    required this.deviceOSVersion,
    required this.deviceIPAddress,
    required this.latitude,
    required this.longitude,
    required this.buyerGcmId,
    required this.appVersion,
  });
}
