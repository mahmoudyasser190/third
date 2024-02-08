import 'package:flutter/material.dart';
import 'package:game_ui/game_ui.dart';
import 'package:get/get.dart';

class EditDrawingButtons extends StatelessWidget {
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onClear;
  final bool isUndoEnabled;
  final bool isRedoEnabled;
  final bool isClearEnabled;

  const EditDrawingButtons({
    required this.onUndo,
    required this.onRedo,
    required this.onClear,
    required this.isUndoEnabled,
    required this.isRedoEnabled,
    required this.isClearEnabled,
    super.key,
  });

  static const Widget _spacingBox = SizedBox(width: 16);

  @override
  Widget build(BuildContext context) {
    const GameIconButtonColorSet colorSet = GameIconButtonColorSet(
      background: Colors.grey,
      border: Colors.blueGrey,
      shadow: Colors.grey,
    );
    final double buttonScale = context.width > 500 ? 1 : (32 / 48);
    return Row(
      children: [
        Opacity(
          opacity: isUndoEnabled ? 1 : 0.5,
          child: Transform.scale(
            scale: buttonScale,
            child: GameIconButton(
              onTap: () {
                if (isUndoEnabled) onUndo();
              },
              colorSet: colorSet,
              icon: const Icon(Icons.undo, color: Colors.black),
            ),
          ),
        ),
        _spacingBox,
        Opacity(
          opacity: isRedoEnabled ? 1 : 0.5,
          child: Transform.scale(
            scale: buttonScale,
            child: GameIconButton(
              onTap: () {
                if (isRedoEnabled) onRedo();
              },
              colorSet: colorSet,
              icon: const Icon(Icons.redo, color: Colors.black),
            ),
          ),
        ),
        _spacingBox,
        Opacity(
          opacity: isClearEnabled ? 1 : 0.5,
          child: Transform.scale(
            scale: buttonScale,
            child: GameIconButton(
              onTap: () {
                if (isClearEnabled) onClear();
              },
              colorSet: colorSet,
              icon: const Icon(Icons.clear, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
