
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

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return Scaffold(
       backgroundColor:AppColors.beige,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
