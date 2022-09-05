// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import 'pages/calendar/calendar_page.dart';
import 'pages/home/home_page.dart';
import 'pages/messages/messages_page.dart';
import 'pages/models/models_page.dart';
import 'pages/placeholder_page.dart';
import 'pages/studios/studios_page.dart';

enum AppPages {
  home(
    page: HomeScreen(),
    icon: Icons.home_outlined,
    title: 'Home',
  ),
  calendar(
    page: CalendarPage(),
    icon: Icons.calendar_today,
    title: 'Calendar',
  ),
  studios(
    page: StudiosPage(),
    icon: Icons.pin_drop,
    title: 'Studios',
  ),
  models(
    page: ModelsPage(),
    icon: Icons.woman,
    title: 'Models',
  ),
  messages(
    page: MessagesPage(),
    icon: Icons.message_rounded,
    title: 'Messages',
  ),
  releases(
    page: PlaceholderPage(),
    icon: Icons.picture_as_pdf,
    title: 'Releases',
  ),
  flights(
    page: PlaceholderPage(),
    icon: Icons.airplane_ticket,
    title: 'Flights',
  ),
  notifications(
    page: PlaceholderPage(),
    icon: Icons.notifications,
    title: 'Notifications',
  ),
  settings(
    page: PlaceholderPage(),
    icon: Icons.settings,
    title: 'Settings',
  );

  const AppPages({
    required this.page,
    required this.icon,
    required this.title,
  });
  final Widget page;
  final IconData icon;
  final String title;

  bool get hasMoreOptions {
    switch (this) {
      case AppPages.home:
      case AppPages.calendar:
      case AppPages.messages:
      case AppPages.notifications:
      case AppPages.settings:
        return false;
      case AppPages.studios:
      case AppPages.models:
      case AppPages.releases:
      case AppPages.flights:
        return true;
    }
  }
}

// The following might not be useful atm and will probably be deleted
// class AppScreensNotifier extends StateNotifier<AppScreens> {
//   AppScreensNotifier() : super(AppScreens.home);
// }
