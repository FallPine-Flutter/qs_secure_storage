# qs_secure_storage

`qs_secure_storage` 是一个用于在 Flutter 项目中持久化保存敏感字符串数据的轻量封装库。

当前库基于 `flutter_secure_storage` 实现，适合保存 token、用户标识、登录态等需要安全存储的小型字符串数据。

## 功能

- 写入字符串
- 读取字符串
- 删除字符串
- 异常时自动通过 `qs_log` 输出错误日志

## 安装

在项目的 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  qs_secure_storage: ^1.0.0
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
await QsSecureStorage.setString('token', 'your_token_value');
```

### 读取字符串

```dart
final token = await QsSecureStorage.getString('token');

if (token != null) {
  // 已读取到本地保存的 token
}
```

### 删除字符串

```dart
await QsSecureStorage.deleteString('token');
```

## 常见使用场景

### 保存登录态

```dart
Future<void> saveLoginInfo({required String token}) async {
  await QsSecureStorage.setString('token', token);
}
```

### 获取登录态

```dart
Future<String?> getLoginToken() async {
  return QsSecureStorage.getString('token');
}
```

### 退出登录时清理数据

```dart
Future<void> logout() async {
  await QsSecureStorage.deleteString('token');
}
```

## API

| 方法 | 说明 |
| --- | --- |
| `QsSecureStorage.setString(String key, String value)` | 根据 key 保存字符串 |
| `QsSecureStorage.getString(String key)` | 根据 key 读取字符串，读取失败或不存在时返回 `null` |
| `QsSecureStorage.deleteString(String key)` | 根据 key 删除已保存的字符串 |

## 注意事项

- 所有读写方法都是异步方法，需要使用 `await` 或 `Future` 处理结果。
- 当前封装只提供字符串类型的读写能力，如果需要保存对象，可以先转换为 JSON 字符串。
- `getString` 在 key 不存在或读取异常时会返回 `null`。
- 建议统一管理 key，避免在项目中散落硬编码字符串。

示例：

```dart
class StorageKeys {
  static const token = 'token';
  static const userId = 'user_id';
}
```

使用：

```dart
await QsSecureStorage.setString(StorageKeys.token, token);
final token = await QsSecureStorage.getString(StorageKeys.token);
```
