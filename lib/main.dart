import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart';
import 'components/drawer/custom_drawer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photoshoot Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto-Light',
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 65, 65, 65),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        drawer: const CustomDrawer(),
        body: const _Pages(),
      ),
    );
  }
}

class _Pages extends ConsumerWidget {
  const _Pages();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = ref.watch(selectedScreenProvider);

    return selectedScreen.page;
  }
}
