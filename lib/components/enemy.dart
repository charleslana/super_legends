import 'package:flutter/material.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class Enemy extends StatelessWidget {
  const Enemy({
    Key? key,
    required this.enemyImage,
    required this.defenseVisible,
    required this.standingEnemyVisible,
    required this.defenseSpriteCount,
    required this.standingEnemySpriteCount,
    required this.playerVisible,
    required this.playerImage,
    required this.playerAttackSpriteCount,
    required this.playerAttackPositionX,
    required this.playerAttackPositionY,
    required this.enemyPositionX,
    required this.enemyPositionY,
  }) : super(key: key);

  final int enemyImage;
  final bool defenseVisible;
  final int defenseSpriteCount;
  final bool standingEnemyVisible;
  final int standingEnemySpriteCount;
  final bool playerVisible;
  final int playerImage;
  final int playerAttackSpriteCount;
  final double playerAttackPositionX;
  final double playerAttackPositionY;
  final double enemyPositionX;
  final double enemyPositionY;

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
          visible: standingEnemyVisible && !defenseVisible,
          child: Container(
            alignment: Alignment(enemyPositionX, enemyPositionY),
            child: Character(
              image: enemyImage,
              direction: DirectionEnum.right,
              move: MoveEnum.standing,
              spriteCount: standingEnemySpriteCount,
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
            alignment: Alignment(enemyPositionX, enemyPositionY),
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
