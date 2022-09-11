import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart';
import 'components/drawer/menu.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
          elevation: 50,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
          //systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Row(
            children: const [
              Menu(),
              Expanded(child: Center(child: _Pages())),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pages extends ConsumerWidget {
  const _Pages();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = ref.watch(selectedPageProvider);

    return selectedScreen.page;
  }
}
