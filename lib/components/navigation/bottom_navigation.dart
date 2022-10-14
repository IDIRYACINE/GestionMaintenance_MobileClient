import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;
  final Function(int) onTap;

  const BottomNavigation({
    Key? key,
    required this.initialIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int? currentIndex; 

  void onTap(int index){
    currentIndex = index;
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {

    currentIndex ??= widget.initialIndex;

    return BottomNavigationBar(
      currentIndex: currentIndex!,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.scanner),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}