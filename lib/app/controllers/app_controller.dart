import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

// enum AppTheme { system, light, dark }

abstract class _AppControllerBase with Store {
  @observable
  ThemeMode appThemeMode = ThemeMode.system;

  @action
  setAppThemeMode(ThemeMode themeMode) => appThemeMode = themeMode;

  @observable
  BuildContext? context;

  @action
  setContext(currentContext) => context = currentContext;

  @observable
  String connectionStatus = 'Unknown';

  @action
  setConnectionStatus(String newValue) {
    print(newValue);
    return connectionStatus = newValue;
  }

  @computed
  bool get noInternet =>
      connectionStatus == 'ConnectivityResult.none' ||
      connectionStatus == 'Unknown';

  @observable
  int indexSelected = 0;

  @observable
  GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

  @observable
  GlobalKey<NavigatorState> searchNavigatorKey = GlobalKey<NavigatorState>();

  @observable
  GlobalKey<NavigatorState> favoritesNavigatorKey = GlobalKey<NavigatorState>();

  @observable
  GlobalKey<NavigatorState> settingsNavigatorKey = GlobalKey<NavigatorState>();
}
