import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/ui/home/home.dart';
import 'package:gestion_maintenance_mobile/ui/scanner/scanner.dart';
import 'package:gestion_maintenance_mobile/ui/settings/settings.dart';

class AppState {
  late bool _isScanning;
  late int _selectedIndex;
  late List<Widget> _pages;

  AppState(
      {int selectedIndex = 0, List<Widget>? pages, bool isScanning = false}) {
    _selectedIndex = selectedIndex;
    _pages =
        pages ?? [const HomePage(), const ScannerPage(), const SettingsPage()];
    _isScanning = isScanning;
  }

  int get selectedIndex => _selectedIndex;
  Widget get selectedPage => _pages[_selectedIndex];

  bool get isScanning => _isScanning;

  AppState copyWith(
      {int? selectedIndex, List<Widget>? pages, bool? isScanning}) {
    return AppState(
        selectedIndex: selectedIndex ?? _selectedIndex,
        pages: pages ?? _pages,
        isScanning: isScanning ?? _isScanning);
  }

  factory AppState.initialState() => AppState();
}
