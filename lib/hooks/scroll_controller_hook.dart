import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useScrollController(AnimationController animationController) {
  return Hook.use(_ScrollControllerHook(animationController: animationController));
}

class _ScrollControllerHook extends Hook<ScrollController> {

  final AnimationController animationController;

  _ScrollControllerHook({@required this.animationController});

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _ScrollControllerHookState();
}

class _ScrollControllerHookState extends HookState<ScrollController, _ScrollControllerHook> {

  ScrollController _scrollController;

  @override
  void initHook() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      switch(_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          hook.animationController.forward();
          break;
        case ScrollDirection.reverse:
          hook.animationController.reverse();
          break;
        default:
          // Do nothing
      }
    });
  }

  @override
  void dispose() => _scrollController.dispose();

  @override
  ScrollController build(BuildContext context) => _scrollController;
}