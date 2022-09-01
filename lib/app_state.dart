// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import './screens/home/home_screen.dart';
import 'screens/placeholder_page.dart';

enum AppScreens {
  home(HomeScreen()),
  calendar(PlaceholderPage()),
  map(PlaceholderPage()),
  clients(PlaceholderPage()),
  chat(PlaceholderPage()),
  documents(PlaceholderPage()),
  travels(PlaceholderPage()),
  notifications(PlaceholderPage()),
  settings(PlaceholderPage());

  const AppScreens(this.screen);
  final Widget screen;
}

// The following might not be useful atm and will probably be deleted
// class AppScreensNotifier extends StateNotifier<AppScreens> {
//   AppScreensNotifier() : super(AppScreens.home);
// }
