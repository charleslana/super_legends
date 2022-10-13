import 'package:flutter/material.dart';
import 'package:super_legends/components/character.dart';
import 'package:super_legends/components/skill.dart';
import 'package:super_legends/enums/direction_enum.dart';
import 'package:super_legends/enums/move_enum.dart';

class Special extends StatelessWidget {
  const Special({
    Key? key,
    required this.direction,
    required this.specialCharacterVisible,
    required this.specialCharacterPositionX,
    required this.specialCharacterPositionY,
    required this.specialCharacterImage,
    required this.specialCharacterSpriteCount,
    required this.specialEffectVisible,
    required this.specialEffectPositionX,
    required this.specialEffectPositionY,
    required this.specialEffectImage,
    required this.specialEffectSpriteCount,
  }) : super(key: key);

  final DirectionEnum direction;
  final bool specialCharacterVisible;
  final double specialCharacterPositionX;
  final double specialCharacterPositionY;
  final int specialCharacterImage;
  final int specialCharacterSpriteCount;

  final bool specialEffectVisible;
  final double specialEffectPositionX;
  final double specialEffectPositionY;
  final int specialEffectImage;
  final int specialEffectSpriteCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /*
        #######################################
        ########## SPECIAL CHARACTER ##########
        #######################################
        */
        Visibility(
          visible: specialCharacterVisible,
          child: Container(
            alignment:
                Alignment(specialCharacterPositionX, specialCharacterPositionY),
            child: Character(
              image: specialCharacterImage,
              direction: direction,
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
              direction: direction,
              spriteCount: specialEffectSpriteCount,
            ),
          ),
        ),
      ],
    );
  }
}
