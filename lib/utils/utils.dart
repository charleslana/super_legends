import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  Utils._();

  static void loadImages(BuildContext context) {
    precacheImage(const AssetImage('assets/images/maps/1.png'), context);
    precacheImage(const AssetImage('assets/images/aura/1/aura1.png'), context);
    precacheImage(const AssetImage('assets/images/aura/1/aura2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/attack0.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/attack1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/attack2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/attack3.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/aura1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/special1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/standing1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/1/standing2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/defense1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/standing1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/standing2.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion0.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion1.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion2.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion3.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion4.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion5.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion6.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion7.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion8.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion9.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion10.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion11.png'), context);
    precacheImage(
        const AssetImage('assets/images/explosion/1/explosion12.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special0.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special1.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special2.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special3.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special4.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special5.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special6.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special7.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/1/special8.png'), context);
  }

  static void loadFonts() {
    FontLoader('ActionComcsBlack')
      ..addFont(rootBundle.load('assets/fonts/Action_Comcs_Black.ttf'))
      ..load();
    FontLoader('AnimeInept')
      ..addFont(rootBundle.load('assets/fonts/Anime_Inept.ttf'))
      ..load();
    FontLoader('KenvectorFuture')
      ..addFont(rootBundle.load('assets/fonts/kenvector_future.ttf'))
      ..load();
  }

  static String numberAbbreviation(dynamic myNumber) {
    final String stringNumber = myNumber.toString();
    final double doubleNumber = double.tryParse(stringNumber) ?? 0;
    final NumberFormat numberFormat = NumberFormat.compact();
    return numberFormat.format(doubleNumber);
  }
}
