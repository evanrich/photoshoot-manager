// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

enum AppScreens {
  home(PlaceholderPage()),
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

// For unimplemented pages
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Photoshoot Manager - Todo page',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
