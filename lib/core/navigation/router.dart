import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/features/home/home.dart';
import 'package:gestion_maintenance_mobile/features/scanner/scanner.dart';
import 'package:gestion_maintenance_mobile/features/settings/settings.dart';

abstract class AppRouter {
  static final List<Widget> _pages = [
    const HomePage(
      testMode: true,
    ),
    const ScannerPage(),
    const SettingsPage()
  ];

  static void setBottomBarIndex(int index) {
    _bottomIndex.value = index;
  }

  static final ValueNotifier<int> _bottomIndex = ValueNotifier<int>(0);

  static ValueNotifier<int> get bottomBarIndex => _bottomIndex;

  static Widget get selectedPage => _pages[_bottomIndex.value];
}
