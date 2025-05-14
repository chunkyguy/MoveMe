import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Move Me', home: MoveMePage());
  }
}

class MoveMePage extends StatefulWidget {
  const MoveMePage({super.key});

  @override
  State<MoveMePage> createState() => _MoveMePageState();
}

class _MoveMePageState extends State<MoveMePage> {
  final _origins = [Offset.zero, Offset.zero, Offset.zero];
  final _size = Size(100, 100);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final window = WidgetsBinding.instance.platformDispatcher.views.first;
      final size = window.physicalSize / window.devicePixelRatio;
      setState(() {
        for (var idx = 0; idx < _origins.length; idx++) {
          // [0,1,2] (x.25) [0,.25,.5] (+.25) [.25,.50,75]
          var dy = (idx.toDouble() * 0.25) + 0.25;
          _origins[idx] = Offset(
            (size.width - _size.width) * 0.5,
            (size.height - _size.height) * dy,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DragTarget<int>(
          builder: (context, accepted, rejected) => Container(),
          onAcceptWithDetails: (details) {
            setState(() {
              _origins[details.data] = details.offset;
            });
          },
        ),
        for (var idx = 0; idx < _origins.length; idx++)
          Positioned(
            top: _origins[idx].dy,
            left: _origins[idx].dx,
            child: _DraggableBox(size: _size, name: idx),
          ),
      ],
    );
  }
}

class _DraggableBox extends StatelessWidget {
  final Size size;
  final int name;

  _DraggableBox({required this.size, required this.name});

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: name,
      feedback: _Box(
        size: size,
        scaleBegin: 1.0,
        scaleEnd: 1.2,
        color: Colors.red,
      ),
      childWhenDragging: Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
      ),
      child: _Box(
        size: size,
        scaleBegin: 1.2,
        scaleEnd: 1.0,
        color: Colors.blue,
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final Size size;
  final double scaleBegin;
  final double scaleEnd;
  final Color color;

  const _Box({
    required this.size,
    required this.scaleBegin,
    required this.scaleEnd,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: scaleBegin, end: scaleEnd),
      duration: Durations.medium1,
      curve: Easing.standardAccelerate,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            color: color,
            width: size.width,
            height: size.height,
          ),
        );
      },
    );
  }
}
