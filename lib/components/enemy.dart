import 'package:flutter/material.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/components/explosion.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';
import 'package:super_legends/utils/theme_utils.dart';

class Enemy extends StatelessWidget {
  const Enemy({
    Key? key,
    required this.enemyImage,
    required this.defenseVisible,
    required this.defenseSpriteCount,
    required this.standingEnemySpriteCount,
    required this.explosionVisible,
    required this.explosionImage,
    required this.explosionSpriteCount,
    required this.explosionEnemyPositionX,
    required this.explosionEnemyPositionY,
    required this.playerVisible,
    required this.playerImage,
    required this.playerAttackSpriteCount,
    required this.playerAttackPositionX,
    required this.playerAttackPositionY,
    required this.damageVisible,
    required this.damagePositionX,
    required this.damagePositionY,
    required this.damage,
    required this.enemyPositionX,
    required this.enemyPositionY,
  }) : super(key: key);

  final int enemyImage;
  final bool defenseVisible;
  final int defenseSpriteCount;
  final int standingEnemySpriteCount;
  final bool explosionVisible;
  final int explosionImage;
  final int explosionSpriteCount;
  final double explosionEnemyPositionX;
  final double explosionEnemyPositionY;
  final bool playerVisible;
  final int playerImage;
  final int playerAttackSpriteCount;
  final double playerAttackPositionX;
  final double playerAttackPositionY;
  final bool damageVisible;
  final double damagePositionX;
  final double damagePositionY;
  final String damage;
  final double enemyPositionX;
  final double enemyPositionY;

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.height / 20;

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
        ########## EXPLOSION EFFECT ###########
        #######################################
        */
        Visibility(
          visible: explosionVisible,
          child: Container(
            alignment:
                Alignment(explosionEnemyPositionX, explosionEnemyPositionY),
            child: Explosion(
              image: explosionImage,
              direction: DirectionEnum.right,
              spriteCount: explosionSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ############ DAMAGE ENEMY #############
        #######################################
        */
        Visibility(
          visible: damageVisible,
          child: Container(
            alignment: Alignment(damagePositionX, damagePositionY),
            child: Text(
              damage,
              style: ThemeUtils.actionComcsBlack().copyWith(
                fontSize: fontSize,
                color: Colors.red,
                shadows: [
                  const Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: Colors.white,
                  ),
                  const Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Colors.white,
                  ),
                  const Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    color: Colors.white,
                  ),
                  const Shadow(
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: Colors.white,
                  ),
                ],
              ),
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
