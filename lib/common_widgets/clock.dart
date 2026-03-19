import 'dart:math' as math;

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60), // Adjust for desired speed
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          // Green border
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.green,
            ),
          ),
          // Inner clock face
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: Colors.white,
            ),
          ),
          // Clock hands
          _buildHand(length: 80, angle: _animationController.value * 360, width: 5),
          _buildHand(length: 60, angle: _animationController.value * 12, width: 3),
          // Text labels
          _buildText(text: '12', angle: 0),
          _buildText(text: '3', angle: 90),
          _buildText(text: '6', angle: 180),
          _buildText(text: '9', angle: 270),
        ],
      ),
    );
  }

  Widget _buildHand({required double length, required double angle, required double width}) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        // angle: AngleAxis.degree(angle).angle,
        transform: Matrix4.identity(),
        child: Container(
          width: width,
          height: length,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildText({required String text, required double angle}) {
    final pi = math.pi;
    final offsetX = math.cos(angle * pi / 180) * 60.0;
    final offsetY = math.sin(angle * pi / 180) * 60.0;
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}