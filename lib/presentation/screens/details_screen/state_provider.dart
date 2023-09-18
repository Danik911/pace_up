import 'package:flutter/cupertino.dart';

class ItemInfoStateProvider extends InheritedWidget {
  final AnimationController slideController;
  final AnimationController rotateController;

  const ItemInfoStateProvider({
    super.key,
    required this.slideController,
    required this.rotateController,
    required Widget child,
  }) : super(child: child);

  static ItemInfoStateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ItemInfoStateProvider>();

    return result!;
  }

  @override
  bool updateShouldNotify(covariant ItemInfoStateProvider oldWidget) => false;
}
