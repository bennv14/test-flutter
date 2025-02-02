import 'dart:developer';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManager {
  CacheManager._();

  static final DefaultCacheManager _cacheManager = DefaultCacheManager();

  static Future<File> getFile(String url) async {
    final file = await _cacheManager.getSingleFile(
      url,
      key: _buildKey(url),
    );
    return file;
  }

  static Future<void> downloadFile(String url) async {
    try {
      _cacheManager.downloadFile(
        url,
        key: _buildKey(url),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static String _buildKey(String url) {
    String fileName = url.split('/').last;
    return fileName;
  }
}
