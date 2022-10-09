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
    required this.auraEffectPositionX,
    required this.auraEffectPositionY,
    required this.auraEffectVisible,
    required this.auraEffectSpriteCount,
    required this.auraCharacterVisible,
    required this.auraCharacterSpriteCount,
    required this.auraCharacterPositionX,
    required this.auraCharacterPositionY,
    required this.standingCharacterVisible,
    required this.standingCharacterSpriteCount,
    required this.standingCharacterPositionX,
    required this.standingCharacterPositionY,
    required this.specialCharacterVisible,
    required this.specialCharacterSpriteCount,
    required this.specialCharacterPositionX,
    required this.specialCharacterPositionY,
    required this.specialEffectImage,
    required this.specialEffectVisible,
    required this.specialEffectSpriteCount,
    required this.specialEffectPositionX,
    required this.specialEffectPositionY,
  }) : super(key: key);

  final int playerImage;
  final int auraEffectImage;
  final double auraEffectPositionX;
  final double auraEffectPositionY;
  final bool auraEffectVisible;
  final int auraEffectSpriteCount;
  final bool auraCharacterVisible;
  final int auraCharacterSpriteCount;
  final double auraCharacterPositionX;
  final double auraCharacterPositionY;
  final bool standingCharacterVisible;
  final int standingCharacterSpriteCount;
  final double standingCharacterPositionX;
  final double standingCharacterPositionY;
  final bool specialCharacterVisible;
  final int specialCharacterSpriteCount;
  final double specialCharacterPositionX;
  final double specialCharacterPositionY;
  final int specialEffectImage;
  final bool specialEffectVisible;
  final int specialEffectSpriteCount;
  final double specialEffectPositionX;
  final double specialEffectPositionY;

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
          visible: auraEffectVisible,
          child: Container(
            alignment: Alignment(auraEffectPositionX, auraEffectPositionY),
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
          visible: auraCharacterVisible,
          child: Container(
            alignment:
                Alignment(auraCharacterPositionX, auraCharacterPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.aura,
              spriteCount: auraCharacterSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ########## STANDING PLAYER ############
        #######################################
        */
        Visibility(
          visible: standingCharacterVisible,
          child: Container(
            alignment: Alignment(
                standingCharacterPositionX, standingCharacterPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.standing,
              spriteCount: standingCharacterSpriteCount,
            ),
          ),
        ),
        /*
        #######################################
        ############ SPECIAL PLAYER ###########
        #######################################
        */
        Visibility(
          visible: specialCharacterVisible,
          child: Container(
            alignment:
                Alignment(specialCharacterPositionX, specialCharacterPositionY),
            child: Character(
              image: playerImage,
              direction: DirectionEnum.left,
              move: MoveEnum.special,
              spriteCount: specialCharacterSpriteCount,
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
      ],
    );
  }
}
