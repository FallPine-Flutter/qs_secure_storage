import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qs_secure_storage_platform_interface.dart';

/// An implementation of [QsSecureStoragePlatform] that uses method channels.
class MethodChannelQsSecureStorage extends QsSecureStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qs_secure_storage');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
