import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/color.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';

import 'package:go_router/go_router.dart';

class TodoNavigationBar extends StatefulWidget {
  const TodoNavigationBar(
      {required this.child, required this.state, super.key});

  final Widget child;
  final GoRouterState state;

  @override
  State<TodoNavigationBar> createState() => _TodoNavigationBarState();
}

class _TodoNavigationBarState extends State<TodoNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('smallNavigationShell'),
            builder: (_) => SizedBox(
              child: widget.child,
            ),
          ),
        },
      ),
      bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: SlotLayout.from(
          key: const Key('smallBottomNavigation'),
          builder: (_) => BottomNavigationBar(
            selectedItemColor: TodoColor.elevatedButtonColorLight,
            unselectedItemColor: TodoColor.lightOnPrimaryColor,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            iconSize: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              currentIndex = index;
              switch (index) {
                case 0:
                  context.goNamed(TodoRouteName.allTodo.name);
                case 1:
                  context.goNamed(TodoRouteName.activeTodo.name);
                case 2:
                  context.goNamed(TodoRouteName.completedTodo.name);
              }
            },
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: BottomIconWidget(isActive: currentIndex == 0),
                label: 'All',
              ),
              BottomNavigationBarItem(
                icon: BottomIconWidget(isActive: currentIndex == 1),
                label: 'Active',
              ),
              BottomNavigationBarItem(
                icon: BottomIconWidget(isActive: currentIndex == 2),
                label: 'Done',
              ),
            ],
          ),
        ),
      }),
    );
  }
}

class BottomIconWidget extends StatelessWidget {
  final bool isActive;
  const BottomIconWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      IconConst.drawer,
      scale: 5,
      color: isActive
          ? TodoColor.elevatedButtonColorLight
          : TodoColor.lightOnPrimaryColor,
    );
  }
}
