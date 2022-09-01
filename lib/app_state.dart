// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'pages/calendar/calendar_page.dart';
import 'pages/home/home_page.dart';
import 'pages/messages/messages_page.dart';
import 'pages/models/models_page.dart';
import 'pages/placeholder_page.dart';
import 'pages/studios/studios_page.dart';

enum AppScreens {
  home(HomeScreen()),
  calendar(CalendarPage()),
  studios(StudiosPage()),
  models(ModelsPage()),
  messages(MessagesPage()),
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
