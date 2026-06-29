import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  final DateTime dueDate;
  const CountDown({super.key, required this.dueDate});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  late DateTime _dueDate;
  late Duration _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    _dueDate = widget.dueDate;
    _calculateRemainingTime();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) => _updateRemainingTime(),
    );
    super.initState();
  }

  void _calculateRemainingTime() {
    setState(() {
      _remainingTime = _dueDate.difference(DateTime.now());
    });
  }

  void _updateRemainingTime() {
    if (_remainingTime.inSeconds > 0) {
      setState(() {
        _remainingTime = _dueDate.difference(DateTime.now());
      });
    } else {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formatted = _formattedDuration(_remainingTime);
    return Text(
      formatted,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }

  String _formattedDuration(Duration duration) {
    if (duration.isNegative) {
      return "Deadline Passed";
    }
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '$hours h $minutes m $seconds s';
  }
}
