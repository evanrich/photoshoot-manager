import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state.dart';

final selectedPageProvider = StateProvider<AppPages>((ref) {
  return AppPages.home;
});
