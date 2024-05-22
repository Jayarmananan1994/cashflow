import 'package:get_it/get_it.dart';

import 'service/game_tracker_service.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerSingleton<GameTrackerService>(GameTrackerService());
}
