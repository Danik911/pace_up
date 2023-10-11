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
              label: 'Where to buy',
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 44),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.blue.withOpacity(0.04);
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed))
                              return Colors.blue.withOpacity(0.12);
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Add to catrt',
                        style:
                        TextStyle
                          (
                            color: Colors.white,
                            fontSize:24,
                            fontFamily: "Roboto"
                        ),
                      )),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
