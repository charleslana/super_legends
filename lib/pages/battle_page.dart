import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:super_legends/components/button.dart';
import 'package:super_legends/components/enemy.dart';
import 'package:super_legends/components/player.dart';
import 'package:super_legends/utils/utils.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  /*
  #######################################
  ################ TIMER ################
  #######################################
  */
  late Timer standingCharacterTimer;
  late Timer attackCharacterTimer;
  late Timer specialCharacterTimer;
  late Timer explosionCharacterTimer;

  /*
  #######################################
  ################ AUDIO ################
  #######################################
  */
  final attackAudio = AudioPlayer();
  final auraAudio = AudioPlayer();
  final specialAudio = AudioPlayer();
  final battleAudio = AudioPlayer();
  late bool isBattleAudioPlaying;

  /*
  #######################################
  ################ MAP ################
  #######################################
  */
  int mapImage = 1;

  /*
  #######################################
  ############## PLAYER 1 ###############
  #######################################
  */
  int imageCharacter1 = 1;
  bool standingPlayer1 = true;
  bool attackPlayer1 = false;
  bool auraPlayer1 = false;
  bool specialPlayer = false;
  bool specialEffect = false;
  bool explosionEffect = false;

  /*
  #######################################
  ############## DYNAMIC ################
  #######################################
  */
  int auraEffectImage = 1;
  int auraCharacterSpriteCount = 1;
  int standingSpriteCount = 1;
  int attackSpriteCount = 0;
  int specialSpriteCount = 1;
  int specialCharacterSpriteCount = 1;
  int specialEffectImage = 1;
  int explosionSpriteCount = 1;
  bool disableActionButton = false;

  /*
  #######################################
  ############## ENEMY 1 ################
  #######################################
  */
  bool defenseEnemy1 = false;
  int imageEnemy1 = 2;
  int defenseEnemySpriteCount = 1;
  int explosionEnemyImage = 1;

  /*
  #######################################
  ############### MOVES #################
  #######################################
  */
  void moveCharacter() {
    standingCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        standingSpriteCount++;

        if (standingSpriteCount > 2) {
          standingSpriteCount = 1;
        }
      });
    });
  }

  void moveCharacterAttack() {
    attackCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        attackSpriteCount++;

        if (attackSpriteCount > 3) {
          attackSpriteCount = 1;
        }
      });
    });
  }

  void moveCharacterSpecial() {
    specialCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        specialSpriteCount++;

        if (specialSpriteCount > 8) {
          specialSpriteCount = 1;
        }
      });
    });
  }

  void moveCharacterExplosion() {
    explosionCharacterTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        explosionSpriteCount++;

        if (explosionSpriteCount > 12) {
          explosionSpriteCount = 1;
        }
      });
    });
  }

  /*
  #######################################
  ############## ATTACK #################
  #######################################
  */
  void playerAttack(int characterPosition) {
    attackAudio.play(AssetSource('audio/teleport_combo.ogg'));
    setState(() {
      disableActionButton = true;
      standingPlayer1 = false;
    });
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      timer.cancel();
      moveCharacterAttack();
      setState(() {
        attackPlayer1 = true;

        defenseEnemy1 = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      attackCharacterTimer.cancel();
      attackAudio.stop();
      setState(() {
        attackPlayer1 = false;
        standingPlayer1 = true;

        defenseEnemy1 = false;

        disableActionButton = false;
        attackSpriteCount = 0;
      });
    });
  }

  /*
  #######################################
  ############### AURA ##################
  #######################################
  */
  void playerAura() {
    auraAudio.play(AssetSource('audio/aura1.ogg'));
    setState(() {
      disableActionButton = true;
      auraPlayer1 = true;
      standingPlayer1 = false;
    });
    Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      timer.cancel();
      auraAudio.stop();
      setState(() {
        disableActionButton = false;
        auraPlayer1 = false;
        standingPlayer1 = true;
      });
    });
  }

  /*
  #######################################
  ############## SPECIAL ################
  #######################################
  */
  void playerSpecial() {
    specialAudio.play(AssetSource('audio/special1.ogg'));
    setState(() {
      disableActionButton = true;
      standingPlayer1 = false;
      specialPlayer = true;
    });
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      timer.cancel();
      moveCharacterSpecial();
      setState(() {
        specialEffect = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 1570), (timer) {
      timer.cancel();
      moveCharacterExplosion();
      setState(() {
        specialEffect = false;
        explosionEffect = true;
        defenseEnemy1 = true;
      });
    });
    Timer.periodic(const Duration(milliseconds: 2200), (timer) {
      timer.cancel();
      specialCharacterTimer.cancel();
      explosionCharacterTimer.cancel();
      specialAudio.stop();
      setState(() {
        specialPlayer = false;
        disableActionButton = false;
        explosionEffect = false;
        standingPlayer1 = true;
        specialSpriteCount = 0;
        explosionSpriteCount = 0;
        defenseEnemy1 = false;
      });
    });
  }

  /*
  #######################################
  ############### AUDIO #################
  #######################################
  */
  void loopBattleAudio() {
    playBattleAudio();
    battleAudio.onPlayerComplete.listen((event) {
      playBattleAudio();
    });
  }

  void playBattleAudio() {
    setState(() {
      isBattleAudioPlaying = true;
    });
    battleAudio.play(AssetSource('audio/battle1.ogg'));
  }

  void stopBattleAudio() {
    setState(() {
      isBattleAudioPlaying = false;
    });
    battleAudio.stop();
  }

  /*
  #######################################
  ############### INIT ##################
  #######################################
  */
  @override
  void initState() {
    loopBattleAudio();
    moveCharacter();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Utils.loadImages(context);
    super.didChangeDependencies();
  }

  /*
  #######################################
  ############## DISPOSE ################
  #######################################
  */
  @override
  void dispose() {
    standingCharacterTimer.cancel();
    battleAudio
      ..stop()
      ..dispose();
    attackAudio.dispose();
    auraAudio.dispose();
    specialAudio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                image: DecorationImage(
                  image: AssetImage('assets/images/maps/$mapImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  /*
                  #######################################
                  ############## PLAYER 1 ###############
                  #######################################
                  */
                  Player(
                    playerImage: imageCharacter1,
                    auraEffectImage: auraEffectImage,
                    auraEffectPositionX: -0.6,
                    auraEffectPositionY: 0.6,
                    auraEffectVisible: auraPlayer1,
                    auraEffectSpriteCount: standingSpriteCount,
                    auraCharacterVisible: auraPlayer1,
                    auraCharacterSpriteCount: auraCharacterSpriteCount,
                    auraCharacterPositionX: -0.6,
                    auraCharacterPositionY: 0.6,
                    standingCharacterVisible: standingPlayer1,
                    standingCharacterSpriteCount: standingSpriteCount,
                    standingCharacterPositionX: -0.6,
                    standingCharacterPositionY: 0.6,
                    specialCharacterVisible: specialPlayer,
                    specialCharacterSpriteCount: specialCharacterSpriteCount,
                    specialCharacterPositionX: -0.2,
                    specialCharacterPositionY: 0.5,
                    specialEffectImage: specialEffectImage,
                    specialEffectVisible: specialEffect,
                    specialEffectSpriteCount: specialSpriteCount,
                    specialEffectPositionX: 0.7,
                    specialEffectPositionY: 0.5,
                  ),
                  /*
                  #######################################
                  ############### ENEMY 1 ###############
                  #######################################
                  */
                  Enemy(
                    enemyImage: imageEnemy1,
                    defenseVisible: defenseEnemy1,
                    defenseSpriteCount: defenseEnemySpriteCount,
                    defenseCharacterPositionX: 0.8,
                    defenseCharacterPositionY: 0.6,
                    standingCharacterSpriteCount: standingSpriteCount,
                    standingCharacterPositionX: 0.8,
                    standingCharacterPositionY: 0.6,
                    explosionVisible: explosionEffect,
                    explosionImage: explosionEnemyImage,
                    explosionSpriteCount: explosionSpriteCount,
                    explosionCharacterPositionX: 0.8,
                    explosionCharacterPositionY: 0.6,
                    playerVisible: attackPlayer1,
                    playerImage: imageCharacter1,
                    playerAttackSpriteCount: attackSpriteCount,
                    playerAttackPositionX: 0.65,
                    playerAttackPositionY: 0.6,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        title: 'Atk base',
                        callback: () => playerAttack(1),
                        disableActionButton: disableActionButton,
                      ),
                      Button(
                        title: 'Ki',
                        callback: playerAura,
                        disableActionButton: disableActionButton,
                      ),
                      Button(
                        title: 'Special',
                        callback: playerSpecial,
                        disableActionButton: disableActionButton,
                      ),
                      Button(
                        title: isBattleAudioPlaying
                            ? 'Stop bg audio'
                            : 'Play bg audio',
                        callback: isBattleAudioPlaying
                            ? stopBattleAudio
                            : playBattleAudio,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
