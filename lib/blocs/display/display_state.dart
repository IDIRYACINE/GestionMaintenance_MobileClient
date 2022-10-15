import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/ui/home/home.dart';
import 'package:gestion_maintenance_mobile/ui/scanner/scanner.dart';
import 'package:gestion_maintenance_mobile/ui/settings/settings.dart';

class DisplayState {
  late int _selectedIndex;

  late List<Widget> _pages;

  DisplayState({int selectedIndex = 0, List<Widget>? pages}) {
    _selectedIndex = selectedIndex;
    _pages =
        pages ?? [const HomePage(), const ScannerPage(), const SettingsPage()];
  }

  int get selectedIndex => _selectedIndex;
  Widget get selectedPage => _pages[_selectedIndex];

  DisplayState copyWith({int? selectedIndex, List<Widget>? pages}) {
    return DisplayState(
        selectedIndex: selectedIndex ?? _selectedIndex, pages: pages ?? _pages);
  }

  factory DisplayState.initialState() => DisplayState();
}
