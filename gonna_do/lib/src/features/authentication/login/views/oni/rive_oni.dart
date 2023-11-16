import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:rive/math.dart' show Vec2D;
import 'package:rive/rive.dart';


class RiveOni {

  RiveOni(Artboard? artboard) {
    if (artboard == null) {
      throw Exception('No artboards cached!');
    }
    _artboard = artboard;

    _controller = StateMachineController(_artboard.stateMachines.first);
    _artboard.addController(_controller);

    /// Also available in _controller.inputs list.
    _exitInput = _controller.findTrigger('exited');
    _pressInput = _controller.findSMI<SMIBool>('thunderGodMode');
  }

   Offset? currentOffset;






  /// The main artboard from which controller, inputs, etc. will be taken.
  late final Artboard _artboard;

  /// Storing all inputs and used here for [pointerMove()] method mainly.
  late final StateMachineController _controller;

  /// Additional exit and onTap/onPress animation triggers.
  SMITrigger? _exitInput;
  SMIBool? _pressInput;

  ///  Artboard to provide for [Rive] widget.
  Artboard get artboard => _artboard;

  /// Shorthand for animations caching, if used before the runApp(),
  /// WidgetsFlutterBinding.ensureInitialized() has to be called first.
  static Future<RiveFile> get cachedAnimation =>
      RiveFile.asset('assets/rive_assets/oni/oni.riv');

  /// Interface for eyes/head moving from pointer's offset coordinates.
  void move(Offset pointer) {
    currentOffset = pointer;
    _controller.pointerMoveFromOffset(pointer);
  }

  /// Fires "exit" animation.
  void onExit() => _exitInput?.fire();

  void updateOffset(int count) => _controller.pointerMoveFromOffset(currentOffset!.translate(count*8, 0));

  /// If there was a tap/click on avatar, plays background animation,
  /// and if it was touch input, move eyes/head to follow it and
  /// reset it after one second with "exit" animation.
  void onTapDown() {
    
    _pressInput?.change(!_pressInput!.value); // Fire background animation.
    log("trying to fire!");
    /// If it's a touch input (typically from smartphone, tablet) - continue,
    /// so users on those devices can enjoy a some interactivity too.
    /* if (details.kind == PointerDeviceKind.touch) {
      move(details.localPosition); // Move head/eyes to the tap position.
      Future.delayed(const Duration(seconds: 1), onExit); // Exit after one sec.
    } */
  }
}


/// Helpers, that are not yet available in [StateMachineController].
extension StateMachineControllerX on StateMachineController {
  void pointerMoveFromOffset(Offset pointerOffset) => pointerMove(
        Vec2D.fromValues(pointerOffset.dx, pointerOffset.dy),
      );

  SMITrigger? findTrigger(String name) {
    final trigger = findInput<bool>(name);

    return trigger is SMITrigger? ? trigger : null;
  }
}
