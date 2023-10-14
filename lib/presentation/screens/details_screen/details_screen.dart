

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/domain/entities/item.dart';
import 'package:pace_up/presentation/screens/details_screen/state_provider.dart';
import 'package:pace_up/presentation/widgets/item_image.dart';
import 'package:pace_up/states/item/item_bloc.dart';
import 'package:pace_up/states/item/item_event.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/images.dart';
import '../../../../states/item/item_selector.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../routes.dart';
import '../../theme/theme_cubit.dart';
import '../../widgets/animated_fade.dart';
import '../../widgets/auto_slideup_panel.dart';
import '../../widgets/hero.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_tab_view.dart';
import 'package:pace_up/presentation/widgets/slide_animation.dart';

import '../cart_screen/bloc/cart_bloc.dart';
part 'sections/backgroud_decoration.dart';
part 'sections/item_info_card.dart';
part 'sections/item_info_card_about.dart';
part 'sections/item_overall_info.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with TickerProviderStateMixin {
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
            _ItemInfoCardBottomPart(),
            _ItemOverallInfo()
          ],
        ),
      ),
    );
  }
}

