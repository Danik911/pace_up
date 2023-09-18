


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pace_up/presentation/screens/details_screen/state_provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ItemInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: const Scaffold(
        body: Stack(
          children: <Widget>[
            _BackgroundDecoration(),
          ],
        ),
      ),
    );
  }

}

