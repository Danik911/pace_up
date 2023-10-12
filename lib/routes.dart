import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pace_up/presentation/screens/cart_screen/cart_screen.dart';
import 'package:pace_up/presentation/screens/details_screen/details_screen.dart';
import 'package:pace_up/presentation/screens/home_screen/home_screen.dart';
import 'core/fade_page_route.dart';

enum Routes { splash, home, details, cart }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String details = '/home/details';
  static const String cart = '/cart';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.details: _Paths.details,
    Routes.cart: _Paths.cart,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case _Paths.home:
        return FadeRoute(page: const HomeScreen());

      case _Paths.details:
        return FadeRoute(page: const DetailsScreen());

      case _Paths.cart:
        return FadeRoute(page: const CartScreen());

      default:
        return FadeRoute(page: const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
