import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_example/hooks/scroll_controller_hook.dart';

class Home extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController = useScrollController(animationController);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Hook Demo'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          return FittedBox(child: FlutterLogo());
        },
        itemCount: 30,
      ),
      floatingActionButton: ScaleTransition(
        scale: animationController,
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: animationController,
          child: FloatingActionButton.extended(
            onPressed: () => print('Clicked'),
            label: const Text('Floating Action Button'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
