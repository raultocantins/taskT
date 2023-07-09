import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppStateObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      if (kDebugMode) {
        print('O aplicativo foi minimizado');
      }
    } else if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print('O aplicativo foi restaurado');
      }
    }
  }
}
