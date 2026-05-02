import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() async {
  final file = File(
    '/Users/aliahmeterdogdu/Projects/deskrelief/lib/l10n/app_en.arb',
  );
  if (!await file.exists()) {
    debugPrint('File not found');
    return;
  }

  final content = await file.readAsString();
  final Map<String, dynamic> data = json.decode(content);
  final newData = <String, dynamic>{};

  // @@locale should be first
  if (data.containsKey('@@locale')) {
    newData['@@locale'] = data['@@locale'];
  }

  // Iterate through keys
  final keys = data.keys.toList()..remove('@@locale');
  for (final key in keys) {
    if (key.startsWith('@')) continue;

    newData[key] = data[key];
    final metadataKey = '@$key';
    if (data.containsKey(metadataKey)) {
      newData[metadataKey] = data[metadataKey];
    } else {
      newData[metadataKey] = {};
    }
  }

  const encoder = JsonEncoder.withIndent('  ');
  await file.writeAsString('${encoder.convert(newData)}\n');
  debugPrint('Successfully added missing metadata blocks.');
}
