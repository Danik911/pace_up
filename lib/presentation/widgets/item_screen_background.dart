
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/colors.dart';
import '../../configs/images.dart';
import '../screens/home_screen/widgets/main_app_bar.dart';
import '../theme/theme_cubit.dart';

class ItemScreenBackground extends StatelessWidget {
  static const double _itemWidthFraction = 0.664;

  final Widget child;
  final Widget? floatingActionButton;

  const ItemScreenBackground({
    Key? key,
    required this.child,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final pokeballSize = MediaQuery.of(context).size.width * _itemWidthFraction;
    final appBarHeight = AppBar().preferredSize.height;
    const iconButtonPadding = mainAppbarPadding;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeballSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin = -(pokeballSize / 2 - iconButtonPadding - iconSize / 2);

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: pokeballTopMargin,
            right: pokeballRightMargin,
            child: Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.05),
            ),
          ),
          child,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
