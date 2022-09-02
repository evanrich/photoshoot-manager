import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_providers.dart';
import '../../app_state.dart';

class CustomListTile extends ConsumerWidget {
  const CustomListTile(
    this.page, {
    super.key,
    required this.isExpanded,
    required this.infoCount,
    this.doHaveMoreOptions,
  });
  final AppPages page;
  final bool isExpanded;
  final int infoCount;
  final IconData? doHaveMoreOptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(selectedPageProvider.notifier).state = page;
      },
      child: SizedBox(
        height: 80,
        width: isExpanded ? 300 : 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment:
                isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Badge(
                showBadge: infoCount > 0,
                badgeContent: Text('$infoCount'),
                badgeColor: Colors.purple.shade200,
                child: Icon(page.icon, color: Colors.white),
              ),
              if (isExpanded) ...[
                const SizedBox(width: 15),
                Text(
                  page.title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: doHaveMoreOptions == null
                        ? const SizedBox.shrink()
                        : IconButton(
                            icon: Icon(
                              doHaveMoreOptions,
                              color: Colors.white,
                              size: 12,
                            ),
                            onPressed: () {},
                          ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
