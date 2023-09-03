import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/presentation/screens/home_screen/widgets/main_app_bar.dart';
import 'package:pace_up/presentation/widgets/item_screen_background.dart';
import '../../../../domain/entities/item.dart';
import '../../../../states/item/item_bloc.dart';
import '../../../../states/item/item_event.dart';
import '../../../../states/item/item_selector.dart';
import '../../../../states/item/item_state.dart';
import '../../../configs/images.dart';
import '../../widgets/item_card.dart';
import '../../widgets/item_refresh_control.dart';

part 'sections/items_grid.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ItemScreenBackground(
      child: Stack(
        children: [
          _ItemsGrid(),
          //_FabMenu(),
        ],
      ),
    );
  }
}

