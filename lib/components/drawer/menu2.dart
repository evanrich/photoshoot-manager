import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_state.dart';
import 'drawer_providers.dart';
import 'header.dart';
import 'menu_tile.dart';

class Menu2 extends ConsumerWidget {
  const Menu2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(isExpandedProvider.notifier).update((state) => true);
    final isExpanded = ref.watch(isExpandedProvider);
    return ColoredBox(
      color: const Color.fromRGBO(20, 20, 20, 1),
      child: AnimatedSize(
        alignment: Alignment.centerLeft,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubicEmphasized,
        child: InkWell(
          onTap: () {
            //ref.read(isExpandedProvider.notifier).update(
            //       (state) => isExpanded ? false : true,
            //     );
            //ref.read(isExpandedProvider.notifier).update((state) => false);
          },
          child: SizedBox(
            //width: isExpanded ? 300 : 65,
            //width: 350,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomDrawerHeader(),
                    Divider(color: Colors.grey),
                    MenuTile(
                      AppPages.home,
                      infoCount: 0,
                    ),
                    MenuTile(
                      AppPages.calendar,
                      infoCount: 0,
                    ),
                    MenuTile(
                      AppPages.studios,
                      infoCount: 0,
                    ),
                    MenuTile(
                      AppPages.models,
                      infoCount: 0,
                    ),
                    MenuTile(
                      AppPages.releases,
                      infoCount: 0,
                    ),
                    Divider(color: Colors.grey),
                    // const Spacer(),
                    MenuTile(
                      AppPages.notifications,
                      infoCount: 2,
                    ),
                    MenuTile(
                      AppPages.settings,
                      infoCount: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
