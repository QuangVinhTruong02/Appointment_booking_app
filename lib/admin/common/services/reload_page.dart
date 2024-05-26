import 'package:booking_doctor/admin/common/services/storage.dart';
import 'package:booking_doctor/admin/common/values/storage.dart';
import 'package:flutter/foundation.dart';

class RouteStorage with ChangeNotifier {
  StorageServiceWeb storageServiceWeb;
  RouteStorage({required this.storageServiceWeb});

  Future<String> getCurrentRoot() async {
    return storageServiceWeb.getString(STORAGE_ROUTE_WEB);
  }

  Future<int> getCurrentIndex() async {
    return storageServiceWeb.getInt(STORAGE_CURRENT_INDEX);
  }

  Future<void> setCurrentRoot(String page) async {
    storageServiceWeb.setString(STORAGE_ROUTE_WEB, page);
  }

  Future<void> setCurrentIndex(int index) async {
    storageServiceWeb.setInt(STORAGE_CURRENT_INDEX, index);
  }
}
