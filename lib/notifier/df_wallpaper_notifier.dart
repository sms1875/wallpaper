import 'package:flutter/material.dart';
import 'package:wallpaper/data/wallpaper.dart';
import 'package:wallpaper/repository/df_wallpaper_repository.dart';

class DungeonAndFighterWallpaperNotifier extends ChangeNotifier {
  DungeonAndFighterWallpaperNotifier();

  DungeonAndFighterWallpaper _wallpaperPage = DungeonAndFighterWallpaper(page: 1, pageUrlsList: [], wallpapers: []);
  DungeonAndFighterWallpaper get wallpaperPage => _wallpaperPage;

  bool _isWallpaperPageLoading = true;
  bool get isWallpaperPageLoading => _isWallpaperPageLoading;

  Object? _wallpaperPageError;
  Object? get wallpaperPageError => _wallpaperPageError;

  int currentPageIndex = 1;

  //초기 설정
  Future<void> update(DungeonAndFighterWallpaperRepository repository) async {
    try {
      _wallpaperPage = (await repository.fetchDungeonAndFighterWallpaper());
      _isWallpaperPageLoading = false;
      _wallpaperPageError = null;
    } catch (e) {
      _wallpaperPage =
          DungeonAndFighterWallpaper(page: 1, pageUrlsList: [], wallpapers: []);
      _isWallpaperPageLoading = false;
      _wallpaperPageError = e;
    }
    notifyListeners();
  }

  //페이지 업데이트
  Future<void> fetchImageListPage(
      DungeonAndFighterWallpaperRepository repository, int page) async {
    currentPageIndex = page;

    try {
      final result =
          await repository.fetchPage(page, wallpaperPage.pageUrlsList);
      _wallpaperPage = DungeonAndFighterWallpaper(
          page: page,
          pageUrlsList: wallpaperPage.pageUrlsList,
          wallpapers: result);
      _isWallpaperPageLoading = false;
      _wallpaperPageError = null;
    } catch (e) {
      _wallpaperPage = DungeonAndFighterWallpaper(
          page: page, pageUrlsList: [], wallpapers: []);
      _isWallpaperPageLoading = false;
      _wallpaperPageError = e;
    }
    notifyListeners();
  }

  void nextPage(DungeonAndFighterWallpaperRepository repository) {
    final nextPage = wallpaperPage.page + 1;
    if (nextPage <= wallpaperPage.pageUrls.length) {
      fetchImageListPage(repository, nextPage);
    }
  }

  void prevPage(DungeonAndFighterWallpaperRepository repository) {
    final prevPage = wallpaperPage.page - 1;
    if (prevPage > 0) {
      fetchImageListPage(repository, prevPage);
    }
  }
}
