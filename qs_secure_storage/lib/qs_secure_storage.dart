import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qs_log/qs_log.dart';

import 'qs_secure_storage_platform_interface.dart';

class QsSecureStorage {
  Future<String?> getPlatformVersion() {
    return QsSecureStoragePlatform.instance.getPlatformVersion();
  }

  static const storage = FlutterSecureStorage();

  /// 设置字符串值
  static Future<void> setString(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      QsLog.error(e.toString());
    }
  }

  /// 获取字符串值
  static Future<String?> getString(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      QsLog.error(e.toString());
      return null;
    }
  }

  /// 删除字符串值
  static Future<void> deleteString(String key) async {
    try {
      await storage.delete(key: key);
    } catch (e) {
      QsLog.error(e.toString());
    }
  }
}
