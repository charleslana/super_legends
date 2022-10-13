import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  Utils._();

  static void loadImages(BuildContext context) {
    /*
    #######################################
    ################ MAP 1 ################
    #######################################
    */
    precacheImage(const AssetImage('assets/images/maps/1.png'), context);
    /*
    #######################################
    ############### AURA 1 ################
    #######################################
    */
    precacheImage(const AssetImage('assets/images/aura/1/aura1.png'), context);
    precacheImage(const AssetImage('assets/images/aura/1/aura2.png'), context);
    precacheImage(const AssetImage('assets/images/aura/2/aura1.png'), context);
    precacheImage(const AssetImage('assets/images/aura/2/aura2.png'), context);
    /*
    #######################################
    ############# CHARACTER 1 #############
    #######################################
    */
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
        const AssetImage('assets/images/characters/1/defense1.png'), context);
    /*
    #######################################
    ############# CHARACTER 2 #############
    #######################################
    */
    precacheImage(
        const AssetImage('assets/images/characters/2/defense1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/standing1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/standing2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack0.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack3.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack4.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack5.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack6.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack7.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack8.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack9.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack10.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/attack11.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/aura1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/special1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/2/special2.png'), context);
    /*
    #######################################
    ############# CHARACTER 3 #############
    #######################################
    */
    precacheImage(
        const AssetImage('assets/images/characters/3/attack0.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/attack1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/attack2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/special1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/standing1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/standing2.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/defense1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/magic1.png'), context);
    precacheImage(
        const AssetImage('assets/images/characters/3/magic2.png'), context);
    /*
    #######################################
    ############# EXPLOSION 1 #############
    #######################################
    */
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
    /*
    #######################################
    ############### SKILL 1 ###############
    #######################################
    */
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
    /*
    #######################################
    ############### SKILL 2 ###############
    #######################################
    */
    precacheImage(
        const AssetImage('assets/images/skill/2/special0.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special1.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special2.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special3.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special4.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special5.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special6.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special7.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special8.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special9.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special10.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special11.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special12.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special13.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special14.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/2/special15.png'), context);
    /*
    #######################################
    ############### SKILL 3 ###############
    #######################################
    */
    precacheImage(
        const AssetImage('assets/images/skill/3/special0.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special1.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special2.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special3.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special4.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special5.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special6.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special7.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special8.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special9.png'), context);
    precacheImage(
        const AssetImage('assets/images/skill/3/special10.png'), context);
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
