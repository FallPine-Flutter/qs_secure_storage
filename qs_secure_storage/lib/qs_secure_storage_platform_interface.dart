import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qs_secure_storage_method_channel.dart';

abstract class QsSecureStoragePlatform extends PlatformInterface {
  /// Constructs a QsSecureStoragePlatform.
  QsSecureStoragePlatform() : super(token: _token);

  static final Object _token = Object();

  static QsSecureStoragePlatform _instance = MethodChannelQsSecureStorage();

  /// The default instance of [QsSecureStoragePlatform] to use.
  ///
  /// Defaults to [MethodChannelQsSecureStorage].
  static QsSecureStoragePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QsSecureStoragePlatform] when
  /// they register themselves.
  static set instance(QsSecureStoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
