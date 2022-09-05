import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photoshoot_manager/components/drawer/drawer_providers.dart';

import '../../app_providers.dart';
import '../../app_state.dart';

class MenuTile extends ConsumerWidget {
  const MenuTile(
    this.page, {
    required this.infoCount,
    super.key,
  });
  final AppPages page;
  final int infoCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(selectedPageProvider.notifier).state = page;
      },
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Badge(
                showBadge: infoCount > 0,
                badgeContent: Text('$infoCount'),
                badgeColor: Colors.purple.shade200,
                child: Icon(page.icon, color: Colors.white),
              ),
              Flexible(child: _ExpandableContent(page)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandableContent extends ConsumerWidget {
  const _ExpandableContent(this.page);
  final AppPages page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(isExpandedProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: isExpanded
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    page.title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  const Spacer(),
                  if (page.hasMoreOptions)
                    IconButton(
                      icon: const Icon(
                        Icons.expand_more,
                        color: Colors.white,
                        size: 12,
                      ),
                      onPressed: () {},
                    )
                  else
                    const SizedBox.shrink()
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
