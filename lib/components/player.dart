import 'package:flutter/material.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class Player extends StatelessWidget {
  const Player({
    Key? key,
    required this.playerImage,
    required this.standingPlayerVisible,
    required this.standingPlayerSpriteCount,
    required this.defenseVisible,
    required this.defenseSpriteCount,
    required this.playerPositionX,
    required this.playerPositionY,
    required this.enemyVisible,
    required this.enemyAttackPositionX,
    required this.enemyAttackPositionY,
    required this.enemyImage,
    required this.enemyAttackSpriteCount,
  }) : super(key: key);

  final int playerImage;
  final bool standingPlayerVisible;
  final int standingPlayerSpriteCount;
  final bool defenseVisible;
  final int defenseSpriteCount;
  final double playerPositionX;
  final double playerPositionY;
  final bool enemyVisible;
  final double enemyAttackPositionX;
  final double enemyAttackPositionY;
  final int enemyImage;
  final int enemyAttackSpriteCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*
        #######################################
        ########## STANDING PLAYER ############
        #######################################
        */
        Visibility(
          visible: standingPlayerVisible && !defenseVisible,
          child: Container(
            alignment: Alignment(playerPositionX, playerPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.standing,
              spriteCount: standingPlayerSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########### DEFENSE PLAYER ############
        #######################################
        */
        Visibility(
          visible: defenseVisible,
          child: Container(
            alignment: Alignment(playerPositionX, playerPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.defense,
              spriteCount: defenseSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########### ATTACK ENEMY ##############
        #######################################
        */
        Visibility(
          visible: enemyVisible,
          child: Container(
            alignment: Alignment(enemyAttackPositionX, enemyAttackPositionY),
            child: Character(
              image: enemyImage,
              direction: DirectionEnum.right,
              move: MoveEnum.attack,
              spriteCount: enemyAttackSpriteCount,
            ),
          ),
        ),
      ],
    );
  }
}
