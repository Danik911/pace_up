import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pace_up/domain/entities/cart_item.dart';
import 'package:pace_up/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:pace_up/presentation/widgets/cart_item_card.dart';
import '../../../configs/images.dart';
import '../../../domain/entities/item.dart';
import '../../../states/item/item_selector.dart';
import '../../widgets/item_refresh_control.dart';
import '../../widgets/item_screen_background.dart';
import '../../widgets/main_app_bar.dart';
import 'bloc/cart_item_selector.dart';

part 'sections/cart_list.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    return const ItemScreenBackground(
      child: Stack(
        children: [
          _CartList(),
        ],
      ),
    );
  }
}
