import 'package:flutter/material.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/components/explosion.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class Enemy extends StatelessWidget {
  const Enemy({
    Key? key,
    required this.enemyImage,
    required this.defenseVisible,
    required this.defenseSpriteCount,
    required this.defenseCharacterPositionX,
    required this.defenseCharacterPositionY,
    required this.standingCharacterSpriteCount,
    required this.standingCharacterPositionX,
    required this.standingCharacterPositionY,
    required this.explosionVisible,
    required this.explosionImage,
    required this.explosionSpriteCount,
    required this.explosionCharacterPositionX,
    required this.explosionCharacterPositionY,
    required this.playerVisible,
    required this.playerImage,
    required this.playerAttackSpriteCount,
    required this.playerAttackPositionX,
    required this.playerAttackPositionY,
  }) : super(key: key);

  final int enemyImage;
  final bool defenseVisible;
  final int defenseSpriteCount;
  final double defenseCharacterPositionX;
  final double defenseCharacterPositionY;
  final int standingCharacterSpriteCount;
  final double standingCharacterPositionX;
  final double standingCharacterPositionY;
  final bool explosionVisible;
  final int explosionImage;
  final int explosionSpriteCount;
  final double explosionCharacterPositionX;
  final double explosionCharacterPositionY;
  final bool playerVisible;
  final int playerImage;
  final int playerAttackSpriteCount;
  final double playerAttackPositionX;
  final double playerAttackPositionY;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*
        #######################################
        ########### STANDING ENEMY ############
        #######################################
        */
        Visibility(
          visible: !defenseVisible,
          child: Container(
            alignment: Alignment(
                standingCharacterPositionX, standingCharacterPositionY),
            child: Character(
              image: enemyImage,
              direction: DirectionEnum.right,
              move: MoveEnum.standing,
              spriteCount: standingCharacterSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########### DEFENSE ENEMY #############
        #######################################
        */
        Visibility(
          visible: defenseVisible,
          child: Container(
            alignment:
                Alignment(defenseCharacterPositionX, defenseCharacterPositionY),
            child: Character(
              image: enemyImage,
              direction: DirectionEnum.right,
              move: MoveEnum.defense,
              spriteCount: defenseSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########## EXPLOSION EFFECT ###########
        #######################################
        */
        Visibility(
          visible: explosionVisible,
          child: Container(
            alignment: Alignment(
                explosionCharacterPositionX, explosionCharacterPositionY),
            child: Explosion(
              image: explosionImage,
              direction: DirectionEnum.right,
              spriteCount: explosionSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########### ATTACK PLAYER #############
        #######################################
        */
        Visibility(
          visible: playerVisible,
          child: Container(
            alignment: Alignment(playerAttackPositionX, playerAttackPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.attack,
              spriteCount: playerAttackSpriteCount,
            ),
          ),
        ),
      ],
    );
  }
}
