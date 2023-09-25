
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configs/colors.dart';
import '../../configs/images.dart';
import 'main_app_bar.dart';
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
    final itemSize = MediaQuery.of(context).size.width * _itemWidthFraction;
    final appBarHeight = AppBar().preferredSize.height;
    const iconButtonPadding = mainAppbarPadding;
    final iconSize = IconTheme.of(context).size ?? 0;

    final itemTopMargin = -(itemSize / 2 - safeAreaTop - appBarHeight / 2);
    final itemRightMargin = -(itemSize / 2 - iconButtonPadding - iconSize / 2);

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isClosed;
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Stack(
        fit: StackFit.expand,
        children: [
      /*    Positioned(
            top: itemTopMargin,
            right: itemRightMargin,
            child: Image(
              image: AppImages.model_4,
              width: itemSize,
              height: itemSize,
              color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.05),
            ),
          ),*/
          child,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
