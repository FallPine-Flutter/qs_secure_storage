import 'package:flutter_test/flutter_test.dart';
import 'package:qs_secure_storage/qs_secure_storage.dart';
import 'package:qs_secure_storage/qs_secure_storage_platform_interface.dart';
import 'package:qs_secure_storage/qs_secure_storage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQsSecureStoragePlatform
    with MockPlatformInterfaceMixin
    implements QsSecureStoragePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QsSecureStoragePlatform initialPlatform = QsSecureStoragePlatform.instance;

  test('$MethodChannelQsSecureStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQsSecureStorage>());
  });

  test('getPlatformVersion', () async {
    QsSecureStorage qsSecureStoragePlugin = QsSecureStorage();
    MockQsSecureStoragePlatform fakePlatform = MockQsSecureStoragePlatform();
    QsSecureStoragePlatform.instance = fakePlatform;

    expect(await qsSecureStoragePlugin.getPlatformVersion(), '42');
  });
}
