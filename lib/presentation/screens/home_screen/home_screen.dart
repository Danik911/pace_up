import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pace_up/domain/entities/item.dart';

import '../../../data/local/boxes/sneakers_boxes.dart';
import '../../widgets/item_card.dart';
import '../add_item_screen/add_sneakers_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const PokeballBackground(
      child: Stack(
        children: [
          _ItemsGrid(),
          //_FabMenu(),TODO("add FAB menu")
        ],
      ),
    );
  }
}
