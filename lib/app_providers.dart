import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state.dart';

final selectedPageProvider = StateProvider<AppScreens>((ref) {
  return AppScreens.home;
});
