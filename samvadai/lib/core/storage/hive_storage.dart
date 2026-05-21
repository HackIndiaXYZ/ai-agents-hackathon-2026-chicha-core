import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HiveStorage {
  static const String settingsBoxName = 'settings_box';
  static const String translationHistoryBoxName = 'history_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBoxName);
    await Hive.openBox(translationHistoryBoxName);
  }

  final Box _settingsBox = Hive.box(settingsBoxName);
  final Box _historyBox = Hive.box(translationHistoryBoxName);

  void save(String key, dynamic value) {
    _settingsBox.put(key, value);
  }

  dynamic get(String key, {dynamic defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue);
  }

  void saveHistory(String id, Map<String, dynamic> log) {
    _historyBox.put(id, log);
  }

  List<Map<String, dynamic>> getHistory() {
    return _historyBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> clearHistory() async {
    await _historyBox.clear();
  }
}

final storageProvider = Provider<HiveStorage>((ref) {
  return HiveStorage();
});
