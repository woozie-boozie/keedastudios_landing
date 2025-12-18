// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class IntroPreferences {
  static const String _hasSeenIntroKey = 'keeda_has_seen_intro';

  static bool hasSeenIntro() {
    return html.window.localStorage[_hasSeenIntroKey] == 'true';
  }

  static void setIntroSeen() {
    html.window.localStorage[_hasSeenIntroKey] = 'true';
  }

  static void resetIntro() {
    html.window.localStorage.remove(_hasSeenIntroKey);
  }
}
