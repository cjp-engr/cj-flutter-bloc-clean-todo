import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

// ignore: must_be_immutable
class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? appBarLeading;
  final Widget? appBarTitle;
  final Widget? floatingActionButton;

  final Widget? body;
  List<Widget>? appBarActions;

  final bool? isAppBarScrollable;
  TodoAppBar({
    super.key,
    this.appBarLeading,
    this.appBarTitle,
    this.floatingActionButton,
    this.body,
    this.appBarActions,
    this.isAppBarScrollable,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                leading: appBarLeading,
                title: appBarTitle,
                actions: appBarActions,
                pinned: true,
              ),
            ];
          },
          body: AdaptiveLayout(
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('smallBody'),
                  builder: (_) => SingleChildScrollView(child: body),
                ),
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('mediumAndUpBody'),
                  builder: (_) => SingleChildScrollView(child: body),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
