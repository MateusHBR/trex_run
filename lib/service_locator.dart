import 'package:get_it/get_it.dart';

import 'screens/trex_game/trex_game.dart';

final locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<TRexGame>(TRexGame());
}
