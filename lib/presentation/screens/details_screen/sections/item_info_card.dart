part of '../details_screen.dart';

class _ItemInfoCard extends StatefulWidget {
  static const double minCardHeightFraction = 0.54;

  const _ItemInfoCard();

  @override
  State<_ItemInfoCard> createState() => _ItemInfoCardState();
}

class _ItemInfoCardState extends State<_ItemInfoCard> {
  AnimationController get slideController =>
      ItemInfoStateProvider.of(context).slideController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * _ItemInfoCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;

    return AutoSlideUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => slideController.value = position,
      child: CurrentItemSelector((item) {
        return MainTabView(
          paddingAnimation: slideController,
          tabs: [
            MainTabData(
              label: 'About',
              child: _ItemAbout(item),
            ),
            MainTabData(
              label: 'Moves',
              child: Align(
                alignment: Alignment.topCenter,
                child: Text('Under development'),
              ),
            ),
          ],
        );
      }),
    );
  }
}
