import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  ScrollController _scrollController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
        vsync: this, duration: kThemeAnimationDuration);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _animationController.reverse();
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _animationController.forward();
      }
    });
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Hook Demo'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return FittedBox(child: FlutterLogo());
        },
        itemCount: 30,
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: _animation,
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
