import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen_state.dart';

final selectedScreenProvider = StateProvider<AppScreens>((ref) {
  return AppScreens.home;
});
