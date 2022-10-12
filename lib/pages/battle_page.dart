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
  Timer damageTimer = Timer.periodic(Duration.zero, (timer) {});

  /*
  #######################################
  ################ AUDIO ################
  #######################################
  */
  bool isAudioActive = true;
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
  bool defensePlayer1 = false;

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
  int specialPlayerImage = 1;

  /*
  #######################################
  ############## ENEMY 1 ################
  #######################################
  */
  bool defenseEnemy1 = false;
  int imageEnemy1 = 2;
  int defenseEnemySpriteCount = 1;
  int explosionEnemyImage = 1;
  bool damageVisible = false;
  double damagePositionY = 0.4;
  String damage = '0';

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
  ############# DAMAGE ##################
  #######################################
  */
  void showDamage() {
    if (damageTimer.isActive) {
      damageTimer.cancel();
    }
    damageTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        damageVisible = true;
        damagePositionY -= 0.01;
        damage = Utils.numberAbbreviation(145210);
      });
      if (damagePositionY < 0.3) {
        timer.cancel();
        setState(() {
          damagePositionY = 0.4;
          damageVisible = false;
        });
      }
    });
  }

  /*
  #######################################
  ############## ATTACK #################
  #######################################
  */
  void playerAttack(int characterPosition) {
    if (isAudioActive) {
      attackAudio.play(AssetSource('audio/teleport_combo.ogg'));
    }
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
      showDamage();
      setState(() {
        attackPlayer1 = false;
        standingPlayer1 = true;

        defenseEnemy1 = false;

        disableActionButton = false;
        attackSpriteCount = 0;
      });
    });
  }

  void enemyAttack(int enemyPosition) {
    setState(() {
      defensePlayer1 = true;
    });
  }

  /*
  #######################################
  ############### AURA ##################
  #######################################
  */
  void playerAura() {
    if (isAudioActive) {
      auraAudio.play(AssetSource('audio/aura1.ogg'));
    }
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
    if (isAudioActive) {
      specialAudio.play(AssetSource('audio/special1.ogg'));
    }
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
        showDamage();
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

  void playEffectAudio() {
    setState(() {
      isAudioActive = true;
    });
  }

  void stopEffectAudio() {
    setState(() {
      isAudioActive = false;
    });
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
    Utils.loadFonts();
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
            flex: 2,
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
                    auraEffectSpriteCount: standingSpriteCount,
                    auraPlayerSpriteCount: auraCharacterSpriteCount,
                    standingPlayerVisible: standingPlayer1,
                    standingPlayerSpriteCount: standingSpriteCount,
                    specialPlayerVisible: specialPlayer,
                    specialPlayerSpriteCount: specialCharacterSpriteCount,
                    specialPlayerPositionX: -0.2,
                    specialPlayerPositionY: 0.5,
                    specialEffectImage: specialEffectImage,
                    specialEffectVisible: specialEffect,
                    specialEffectSpriteCount: specialSpriteCount,
                    specialEffectPositionX: 0.7,
                    specialEffectPositionY: 0.5,
                    defenseSpriteCount: 1,
                    defenseVisible: defensePlayer1,
                    auraVisible: auraPlayer1,
                    playerPositionX: -0.6,
                    playerPositionY: 0.6,
                    specialPlayerImage: specialPlayerImage,
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
                    standingEnemySpriteCount: standingSpriteCount,
                    explosionVisible: explosionEffect,
                    explosionImage: explosionEnemyImage,
                    explosionSpriteCount: explosionSpriteCount,
                    explosionEnemyPositionX: 0.8,
                    explosionEnemyPositionY: 0.6,
                    playerVisible: attackPlayer1,
                    playerImage: imageCharacter1,
                    playerAttackSpriteCount: attackSpriteCount,
                    playerAttackPositionX: 0.65,
                    playerAttackPositionY: 0.6,
                    damageVisible: damageVisible,
                    damagePositionX: 0.7,
                    damagePositionY: damagePositionY,
                    damage: damage,
                    enemyPositionX: 0.8,
                    enemyPositionY: 0.6,
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
                      Column(
                        children: [
                          Button(
                            title: 'Atk base',
                            callback: () => playerAttack(1),
                            disableActionButton: disableActionButton,
                          ),
                          Button(
                            title: 'Atk base enemy',
                            callback: () => enemyAttack(1),
                            disableActionButton: disableActionButton,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Button(
                            title: 'Ki',
                            callback: playerAura,
                            disableActionButton: disableActionButton,
                          ),
                          Button(
                            title: 'Ki enemy',
                            callback: () {},
                            disableActionButton: disableActionButton,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Button(
                            title: 'Special',
                            callback: playerSpecial,
                            disableActionButton: disableActionButton,
                          ),
                          Button(
                            title: 'Special enemy',
                            callback: () {},
                            disableActionButton: disableActionButton,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Button(
                            title: isBattleAudioPlaying
                                ? 'Stop bg audio'
                                : 'Play bg audio',
                            callback: isBattleAudioPlaying
                                ? stopBattleAudio
                                : playBattleAudio,
                          ),
                          Button(
                            title: isAudioActive
                                ? 'Stop effect audio'
                                : 'Play effect audio',
                            callback: isAudioActive
                                ? stopEffectAudio
                                : playEffectAudio,
                          ),
                        ],
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
