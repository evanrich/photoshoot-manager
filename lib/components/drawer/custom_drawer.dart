import 'package:flutter/material.dart';
import 'package:photoshoot_manager/app_state.dart';
import 'package:photoshoot_manager/components/drawer/bottom_user_info.dart';
import 'package:photoshoot_manager/components/drawer/custom_list_tile.dart';
import 'package:photoshoot_manager/components/drawer/header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(20, 20, 20, 1),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDrawerHeader(isColapsed: _isCollapsed),
                const Divider(
                  color: Colors.grey,
                ),
                CustomListTile(
                  AppPages.home,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                ),
                CustomListTile(
                  AppPages.calendar,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                ),
                CustomListTile(
                  AppPages.studios,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                  doHaveMoreOptions: Icons.arrow_forward_ios,
                ),
                CustomListTile(
                  AppPages.models,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                  doHaveMoreOptions: Icons.arrow_forward_ios,
                ),
                CustomListTile(
                  AppPages.messages,
                  isCollapsed: _isCollapsed,
                  infoCount: 8,
                ),
                CustomListTile(
                  AppPages.releases,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                  doHaveMoreOptions: Icons.arrow_forward_ios,
                ),
                CustomListTile(
                  AppPages.flights,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                  doHaveMoreOptions: Icons.arrow_forward_ios,
                ),
                const Divider(color: Colors.grey),
                // const Spacer(),
                CustomListTile(
                  AppPages.notifications,
                  isCollapsed: _isCollapsed,
                  infoCount: 2,
                ),
                CustomListTile(
                  AppPages.settings,
                  isCollapsed: _isCollapsed,
                  infoCount: 0,
                ),
                const SizedBox(height: 10),
                Flexible(child: BottomUserInfo(isCollapsed: _isCollapsed)),
                Align(
                  alignment: _isCollapsed
                      ? Alignment.bottomRight
                      : Alignment.bottomCenter,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _isCollapsed
                          ? Icons.arrow_back_ios
                          : Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
