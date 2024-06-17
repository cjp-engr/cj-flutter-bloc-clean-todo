import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:frontend/2_application/core/utils/color.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:go_router/go_router.dart';

class TodoNavigationBar extends StatelessWidget {
  final StatefulNavigationShell? navigationShell;
  const TodoNavigationBar({
    Key? key,
    this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('TodoNavigationBar'));

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('smallNavigationShell'),
            builder: (_) => SizedBox(
              child: navigationShell,
            ),
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('smallBottomNavigation'),
            builder: (_) => _CustomBottomNavigation(navigationShell),
          ),
        },
      ),
    );
  }
}

class _CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell? navigationShell;
  const _CustomBottomNavigation(this.navigationShell);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationShell!.currentIndex,
      onTap: (index) => _onDestinationSelected(index),
      selectedItemColor: TodoColor.lightOnPrimaryColor,
      unselectedItemColor: TodoColor.lightPrimaryVariantColor,
      items: _bottomNavigationList(context),
      selectedFontSize: 0,
      unselectedFontSize: 0,
      iconSize: 0,
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell!.goBranch(
      index,
      initialLocation: index == navigationShell!.currentIndex,
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationList(BuildContext context) {
    return [
      const BottomNavigationBarItem(
        icon: TodoText(text: 'All'),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: TodoText(text: 'Active'),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: TodoText(text: 'Completed'),
        label: '',
      ),
    ];
  }
}
