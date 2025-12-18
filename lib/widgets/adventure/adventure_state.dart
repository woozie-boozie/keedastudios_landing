import 'package:flutter/foundation.dart';
import 'adventure_data.dart';

class AdventureState extends ChangeNotifier {
  int _currentPanelIndex = 0;
  String _currentPath = '';
  bool _isComplete = false;
  bool _isSkipped = false;
  bool _isAnimating = false;
  bool _dialogueComplete = false;

  int get currentPanelIndex => _currentPanelIndex;
  String get currentPath => _currentPath;
  bool get isComplete => _isComplete;
  bool get isSkipped => _isSkipped;
  bool get isAnimating => _isAnimating;
  bool get dialogueComplete => _dialogueComplete;

  AdventurePanel get currentPanel {
    switch (_currentPanelIndex) {
      case 0:
        return AdventureContent.panel1;
      case 1:
        return AdventureContent.getPanel2(_currentPath);
      case 2:
        return AdventureContent.getPanel3(_currentPath);
      default:
        return AdventureContent.panel1;
    }
  }

  void setDialogueComplete(bool complete) {
    _dialogueComplete = complete;
    notifyListeners();
  }

  void selectChoice(String choiceId) {
    if (_isAnimating) return;

    _isAnimating = true;
    _dialogueComplete = false;

    if (_currentPanelIndex == 0) {
      _currentPath = choiceId;
    } else {
      _currentPath = choiceId;
    }

    _currentPanelIndex++;

    if (_currentPanelIndex >= 3) {
      _isComplete = true;
    }

    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      _isAnimating = false;
      notifyListeners();
    });
  }

  void completeIntro() {
    _isComplete = true;
    notifyListeners();
  }

  void skipIntro() {
    _isSkipped = true;
    _isComplete = true;
    notifyListeners();
  }

  void reset() {
    _currentPanelIndex = 0;
    _currentPath = '';
    _isComplete = false;
    _isSkipped = false;
    _isAnimating = false;
    _dialogueComplete = false;
    notifyListeners();
  }
}
