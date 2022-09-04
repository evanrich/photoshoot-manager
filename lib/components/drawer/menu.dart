import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_state.dart';
import 'bottom_user_info.dart';
import 'drawer_providers.dart';
import 'header.dart';
import 'menu_tile.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(isExpandedProvider);

    return ColoredBox(
      color: const Color.fromRGBO(20, 20, 20, 1),
      child: AnimatedSize(
        alignment: Alignment.centerLeft,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: InkWell(
          onTap: () {
            ref.read(isExpandedProvider.notifier).update((state) => !state);
          },
          child: SizedBox(
            width: isExpanded ? 350 : 70,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomDrawerHeader(),
                    const Divider(color: Colors.grey),
                    const MenuTile(
                      AppPages.home,
                      infoCount: 0,
                    ),
                    const MenuTile(
                      AppPages.calendar,
                      infoCount: 0,
                    ),
                    const MenuTile(
                      AppPages.studios,
                      infoCount: 0,
                    ),
                    const MenuTile(
                      AppPages.models,
                      infoCount: 0,
                    ),
                    const MenuTile(
                      AppPages.messages,
                      infoCount: 8,
                    ),
                    const MenuTile(
                      AppPages.releases,
                      infoCount: 0,
                    ),
                    const MenuTile(
                      AppPages.flights,
                      infoCount: 0,
                    ),
                    const Divider(color: Colors.grey),
                    // const Spacer(),
                    const MenuTile(
                      AppPages.notifications,
                      infoCount: 2,
                    ),
                    const MenuTile(
                      AppPages.settings,
                      infoCount: 0,
                    ),
                    const SizedBox(height: 10),
                    const Flexible(child: BottomUserInfo()),
                    Align(
                      alignment: isExpanded
                          ? Alignment.bottomRight
                          : Alignment.bottomCenter,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          isExpanded
                              ? Icons.arrow_back_ios
                              : Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                        onPressed: () {
                          ref
                              .read(isExpandedProvider.notifier)
                              .update((state) => !state);
                        },
                      ),
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
