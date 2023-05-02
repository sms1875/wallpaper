import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/df_wallpaper_provider.dart';
import 'package:wallpaper/screen/wallpaper_screen.dart';

class DungeonAndFighterWallpaperScreen extends StatefulWidget {
  @override
  State<DungeonAndFighterWallpaperScreen> createState() =>
      _DungeonAndFighterWallpaperScreenState();
}

class _DungeonAndFighterWallpaperScreenState
    extends State<DungeonAndFighterWallpaperScreen> with WallpaperScreen {

  @override
  Widget build(BuildContext context) {
    return Consumer<DungeonAndFighterWallpaperProvider>(
      builder: (context, dungeonAndFighterProvider, child) {
        final currentPage = dungeonAndFighterProvider.currentPageIndex;
        final wallpapers = dungeonAndFighterProvider.wallpaperPage.wallpapers;
        final pageNumbers = List.generate(
            dungeonAndFighterProvider.wallpaperPage.pageUrlsList.length,
            (index) => index + 1);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 16,
                    ),
                    itemCount: wallpapers.length,
                    itemBuilder: (context, index) {
                      final wallpaper = wallpapers[index];
                      var url = wallpaper['src']!;
                      return buildCardWidget(url);
                    },
                    controller: scrollController),
              ),
              buildPageNumbers(pageNumbers, currentPage, dungeonAndFighterProvider)
            ],
          ),
        );
      },
    );
  }
}