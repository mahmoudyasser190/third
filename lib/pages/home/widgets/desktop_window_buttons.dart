import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:window_manager/window_manager.dart';

class DesktopWindowButtons extends StatelessWidget {
  final VoidCallback onReset;

  const DesktopWindowButtons({required this.onReset, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameIconButton(
                onTap: () => onReset(),
                colorSet: GameIconButtonColorSet.green,
                size: 32,
                icon: const SizedBox(),
              ),
              const SizedBox(width: 16),
              GameIconButton(
                onTap: () async => await windowManager.minimize(),
                colorSet: GameIconButtonColorSet.yellow,
                size: 32,
                icon: const SizedBox(),
              ),
              const SizedBox(width: 16),
              GameIconButton(
                onTap: () async => await windowManager.close(),
                colorSet: GameIconButtonColorSet.red,
                size: 32,
                icon: const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
