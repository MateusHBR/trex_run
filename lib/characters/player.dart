import 'package:flutter/foundation.dart';

const kPlayerLives = 3;

class PlayerData extends ChangeNotifier {
  int _lives = kPlayerLives;

  int get lives => _lives;
  set lives(int value) {
    if (value <= 5 && value >= 0) {
      _lives = value;
      notifyListeners();
    }
  }

  int _currentScore = 0;

  int get currentScore => _currentScore;
  set currentScore(int value) {
    _currentScore = value;

    notifyListeners();
  }
}
