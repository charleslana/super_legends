import 'package:flutter/material.dart';
import 'package:super_legends/components/aura.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/components/skill.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class Player extends StatelessWidget {
  const Player({
    Key? key,
    required this.playerImage,
    required this.auraEffectImage,
    required this.auraEffectSpriteCount,
    required this.auraPlayerSpriteCount,
    required this.standingPlayerVisible,
    required this.standingPlayerSpriteCount,
    required this.specialPlayerVisible,
    required this.specialPlayerSpriteCount,
    required this.specialPlayerPositionX,
    required this.specialPlayerPositionY,
    required this.specialEffectImage,
    required this.specialEffectVisible,
    required this.specialEffectSpriteCount,
    required this.specialEffectPositionX,
    required this.specialEffectPositionY,
    required this.defenseVisible,
    required this.defenseSpriteCount,
    required this.playerPositionX,
    required this.playerPositionY,
    required this.auraVisible,
    required this.specialPlayerImage,
    required this.enemyVisible,
    required this.enemyAttackPositionX,
    required this.enemyAttackPositionY,
    required this.enemyImage,
    required this.enemyAttackSpriteCount,
  }) : super(key: key);

  final int playerImage;
  final int auraEffectImage;
  final int auraEffectSpriteCount;
  final int auraPlayerSpriteCount;
  final bool standingPlayerVisible;
  final int standingPlayerSpriteCount;
  final bool specialPlayerVisible;
  final int specialPlayerSpriteCount;
  final double specialPlayerPositionX;
  final double specialPlayerPositionY;
  final int specialEffectImage;
  final bool specialEffectVisible;
  final int specialEffectSpriteCount;
  final double specialEffectPositionX;
  final double specialEffectPositionY;
  final bool defenseVisible;
  final int defenseSpriteCount;
  final double playerPositionX;
  final double playerPositionY;
  final bool auraVisible;
  final int specialPlayerImage;
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
        ############# AURA EFFECT #############
        #######################################
        */
        Visibility(
          visible: auraVisible,
          child: Container(
            alignment: Alignment(playerPositionX, playerPositionY),
            child: Aura(
              image: auraEffectImage,
              direction: DirectionEnum.left,
              spriteCount: auraEffectSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ############# AURA PLAYER #############
        #######################################
        */
        Visibility(
          visible: auraVisible,
          child: Container(
            alignment: Alignment(playerPositionX, playerPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.aura,
              spriteCount: auraPlayerSpriteCount,
            ),
          ),
        ),
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
        ############ SPECIAL PLAYER ###########
        #######################################
        */
        Visibility(
          visible: specialPlayerVisible,
          child: Container(
            alignment:
                Alignment(specialPlayerPositionX, specialPlayerPositionY),
            child: Character(
              image: specialPlayerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.special,
              spriteCount: specialPlayerSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########### SPECIAL EFFECT ############
        #######################################
        */
        Visibility(
          visible: specialEffectVisible,
          child: Container(
            alignment:
                Alignment(specialEffectPositionX, specialEffectPositionY),
            child: Skill(
              image: specialEffectImage,
              direction: DirectionEnum.left,
              spriteCount: specialEffectSpriteCount,
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
