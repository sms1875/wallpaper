import 'package:flutter/material.dart';
import 'package:wallpaper/data/wallpaper.dart';

abstract class WallpaperProvider extends ChangeNotifier {
  Wallpaper _wallpaperPage = Wallpaper(page: 1, pageUrls: [], wallpapers: []);
  Wallpaper get wallpaperPage => _wallpaperPage;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Object? _error;
  Object? get error => _error;

  int currentPageIndex = 1;

  Future<void> update() async {}

  Future<void> fetchPage(int page) async {
    currentPageIndex = page;
  }

  void nextPage() {
    final nextPage = wallpaperPage.page + 1;
    if (nextPage <= wallpaperPage.pageUrls.length) {
      fetchPage(nextPage);
    }
  }

  void prevPage() {
    final prevPage = wallpaperPage.page - 1;
    if (prevPage > 0) {
      fetchPage(prevPage);
    }
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  void setError(Object error) {
    _error = error;
    setLoading(false);
  }

  void setWallpaper(Wallpaper wallpaper) {
    _wallpaperPage = wallpaper;
    setLoading(false);
  }
}
