sed -i '/<<<<<<< Updated upstream/d' lib/providers/network_service.dart
sed -i '/=======/d' lib/providers/network_service.dart
sed -i '/>>>>>>> Stashed changes/d' lib/providers/network_service.dart
sed -i 's/log("Error getting active network info: $e");/log("Error getting active network info: $e", name: '\''NetworkService'\'', error: e);/g' lib/providers/network_service.dart
sed -i 's/log("NetworkService: _getNetworkInformation: $map");/log("_getNetworkInformation: $map", name: '\''NetworkService'\'');/g' lib/providers/network_service.dart
sed -i 's/log("NetworkService: parsed type $_networkType, signal $_wirelessNetworkSignalLevel");/log("parsed type $_networkType, signal $_wirelessNetworkSignalLevel", name: '\''NetworkService'\'');/g' lib/providers/network_service.dart
sed -i 's/log("NetworkService error parsing: $e");/log("error parsing: $e", name: '\''NetworkService'\'', error: e);/g' lib/providers/network_service.dart
