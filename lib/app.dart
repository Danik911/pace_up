import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:pace_up/configs/theme.dart';
import 'package:pace_up/presentation/theme/theme_cubit.dart';
import 'package:pace_up/routes.dart';
import 'configs/constants.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return FlutterWebFrame(
      maximumSize: const Size.fromWidth(600),
      backgroundColor: isDark ? Colors.black12 : Colors.grey[200],
      enabled: kIsWeb || !Platform.isAndroid && !Platform.isIOS,
      builder: (context) {
        return MaterialApp(
          color: Colors.white,
          title: 'Pace UP',
          theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
          navigatorKey: AppNavigator.navigatorKey,
          onGenerateRoute: AppNavigator.onGenerateRoute,
          builder: (context, child) {
            if (child == null) return const SizedBox.shrink();

            final data = MediaQuery.of(context);
            final smallestSize = min(data.size.width, data.size.height);
            final textScaleFactor = min(smallestSize / AppConstants.designScreenSize.width, 1.0);

            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: textScaleFactor,
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}
