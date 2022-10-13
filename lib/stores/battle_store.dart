import 'package:flutter/material.dart';

class BattleStore extends ValueNotifier<String> {
  BattleStore() : super('teste');

  void change() {
    value = 'test2';
  }
}
