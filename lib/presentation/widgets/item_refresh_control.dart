import 'package:flutter/cupertino.dart';

import '../../configs/images.dart';

class ItemRefreshControl extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const ItemRefreshControl({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (_, __, ___, ____, _____) => const Image(
        image: AppImages.pikloader,
      ),
    );
  }
}
