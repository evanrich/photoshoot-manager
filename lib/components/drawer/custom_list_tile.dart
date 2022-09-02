import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_providers.dart';
import '../../app_state.dart';

class CustomListTile extends ConsumerWidget {
  const CustomListTile(
    this.page, {
    super.key,
    required this.isCollapsed,
    required this.infoCount,
    this.doHaveMoreOptions,
  });
  final AppPages page;
  final bool isCollapsed;
  final int infoCount;
  final IconData? doHaveMoreOptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(selectedPageProvider.notifier).state = page;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: isCollapsed ? 300 : 80,
        height: 80,
        child: Row(
          children: [
            Badge(
              showBadge: infoCount > 0,
              badgeContent: Text('$infoCount'),
              badgeColor: Colors.purple.shade200,
              child: Icon(page.icon, color: Colors.white),
            ),
            if (isCollapsed) const SizedBox(width: 10),
            if (isCollapsed)
              Expanded(
                child: Text(
                  page.title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            if (isCollapsed) const Spacer(),
            if (isCollapsed)
              Expanded(
                child: doHaveMoreOptions != null
                    ? IconButton(
                        icon: Icon(
                          doHaveMoreOptions,
                          color: Colors.white,
                          size: 12,
                        ),
                        onPressed: () {},
                      )
                    : const Center(),
              ),
          ],
        ),
      ),
    );
  }
}
