# qs_secure_storage

`qs_secure_storage` 是一个用于 Flutter 项目的安全存储封装库，适合持久化保存 token、用户标识、登录态等敏感字符串数据。

当前库基于 `flutter_secure_storage` 实现，并通过 `qs_log` 输出异常日志。

## 功能

- 安全写入字符串
- 安全读取字符串
- 删除指定 key 对应的数据
- 读取失败或写入失败时自动记录错误日志

## 平台支持

当前插件配置支持：

| 平台 | 支持 |
| --- | --- |
| Android | 支持 |
| iOS | 支持 |

## 安装

在项目的 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  qs_secure_storage: ^1.0.2
```

如果是本地插件调试，可以使用 path 方式引入：

```yaml
dependencies:
  qs_secure_storage:
    path: ../qs_secure_storage
```

然后执行：

```bash
flutter pub get
```

## 导入

```dart
import 'package:qs_secure_storage/qs_secure_storage.dart';
```

## 基础用法

### 保存字符串

```dart
await QsSecureStorage.setString(
  key: 'token',
  value: 'your_token_value',
);
```

### 读取字符串

```dart
final token = await QsSecureStorage.getString(key: 'token');

if (token != null) {
  // 已读取到本地保存的 token
}
```

### 删除字符串

```dart
await QsSecureStorage.deleteString(key: 'token');
```

## 常见使用场景

### 统一管理存储 key

建议在业务项目中统一维护 key，避免硬编码字符串散落在各个页面或服务中。

```dart
class StorageKeys {
  static const token = 'token';
  static const userId = 'user_id';
}
```

### 保存登录态

```dart
Future<void> saveLoginInfo({required String token}) async {
  await QsSecureStorage.setString(
    key: StorageKeys.token,
    value: token,
  );
}
```

### 获取登录态

```dart
Future<String?> getLoginToken() async {
  return QsSecureStorage.getString(key: StorageKeys.token);
}
```

### 退出登录时清理数据

```dart
Future<void> logout() async {
  await QsSecureStorage.deleteString(key: StorageKeys.token);
}
```

### 保存对象数据

当前库只提供字符串存取能力。如果需要保存对象，可以先转换为 JSON 字符串。

```dart
import 'dart:convert';

Future<void> saveUserInfo({
  required String userId,
  required String nickname,
}) async {
  final jsonString = jsonEncode({
    'userId': userId,
    'nickname': nickname,
  });

  await QsSecureStorage.setString(
    key: 'user_info',
    value: jsonString,
  );
}
```

### 读取对象数据

```dart
import 'dart:convert';

Future<Map<String, dynamic>?> getUserInfo() async {
  final jsonString = await QsSecureStorage.getString(key: 'user_info');
  if (jsonString == null) {
    return null;
  }

  return jsonDecode(jsonString) as Map<String, dynamic>;
}
```

## API

| 方法 | 说明 |
| --- | --- |
| `QsSecureStorage.setString({required String key, required String value})` | 根据 key 保存字符串 |
| `QsSecureStorage.getString({required String key})` | 根据 key 读取字符串，读取失败或不存在时返回 `null` |
| `QsSecureStorage.deleteString({required String key})` | 根据 key 删除已保存的字符串 |

## 注意事项

- 所有读写方法都是异步方法，需要使用 `await` 或 `Future` 处理结果。
- `getString` 在 key 不存在或读取异常时会返回 `null`。
- 不建议保存大量数据，安全存储更适合 token、密钥、用户标识等小型敏感数据。
- 建议统一管理 key，避免 key 拼写错误导致读取不到数据。
