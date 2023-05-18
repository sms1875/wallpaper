import 'package:flutter/material.dart';
import 'package:wallpaper/screen/apexlegends_wallpaper_screen.dart';
import 'package:wallpaper/screen/blackdesert_wallpaper_screen.dart';
import 'package:wallpaper/screen/df_wallpaper_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("온라인 게임", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(
            child: buildGameGrid(context, onlineGames),
          ),
          /*
          SizedBox(height: 20),
          Text("콘솔 게임", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Expanded(
            child: buildGameGrid(context, consoleGames),
          ),*/
        ],
      ),
    );
  }

  Widget buildGameGrid(BuildContext context, List<Map<String, dynamic>> games) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: games.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return buildButton(context, games[index]['title'], games[index]['image'], games[index]['page']);
      },
    );
  }

  Widget buildButton(BuildContext context, String title, String image, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> onlineGames = [
  {
    'title': 'Black Desert',
    'image': 'assets/images/blackdesert.png',
    'page': BlackDesertWallpaperScreen(),
  },
  {
    'title': 'Dungeon & Fighter',
    'image': 'assets/images/dungeon&fighter.png',
    'page': DungeonAndFighterWallpaperScreen(),
  },
  {
    'title': 'Apex Legends',
    'image': 'assets/images/apexlegends.webp',
    'page': ApexLegendsWallpaperScreen(),
  },
];

final List<Map<String, dynamic>> consoleGames = [
  // 콘솔 게임에 대한 데이터 추가
];