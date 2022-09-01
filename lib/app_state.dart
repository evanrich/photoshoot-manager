// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'pages/calendar/calendar_page.dart';
import 'pages/clients/clients_page.dart';
import 'pages/home/home_page.dart';
import 'pages/map/map_page.dart';
import 'pages/placeholder_page.dart';

enum AppScreens {
  home(HomeScreen()),
  calendar(CalendarPage()),
  map(MapPage()),
  clients(ClientsPage()),
  chat(PlaceholderPage()),
  documents(PlaceholderPage()),
  travels(PlaceholderPage()),
  notifications(PlaceholderPage()),
  settings(PlaceholderPage());

  const AppScreens(this.page);
  final Widget page;
}

// The following might not be useful atm and will probably be deleted
// class AppScreensNotifier extends StateNotifier<AppScreens> {
//   AppScreensNotifier() : super(AppScreens.home);
// }
