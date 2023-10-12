part of '../details_screen.dart';

class _ItemOverallInfo extends StatefulWidget {
  const _ItemOverallInfo();

  @override
  _ItemOverallInfoState createState() => _ItemOverallInfoState();
}

class _ItemOverallInfoState extends State<_ItemOverallInfo>
    with TickerProviderStateMixin {
  static const double _itemSliderViewportFraction = 0.56;
  static const int _endReachedThreshold = 4;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();

  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;
  late PageController _pageController;
  late AnimationController _horizontalSlideController;

  ItemBloc get itemBlock => context.read<ItemBloc>();

  AnimationController get slideController =>
      ItemInfoStateProvider.of(context).slideController;

  AnimationController get rotateController =>
      ItemInfoStateProvider.of(context).rotateController;

  Animation<double> get textFadeAnimation =>
      Tween(begin: 1.0, end: 0.0).animate(slideController);

  Animation<double> get sliderFadeAnimation =>
      Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: slideController,
        curve: Interval(0.0, 0.5, curve: Curves.ease),
      ));

  @override
  void initState() {
    _horizontalSlideController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
    )..forward();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final pageIndex = itemBlock.state.selectedItemIndex;

    _pageController = PageController(
      viewportFraction: _itemSliderViewportFraction,
      initialPage: pageIndex,
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _horizontalSlideController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  void _calculateItemNamePosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetTextBox =
          _targetTextKey.currentContext?.findRenderObject() as RenderBox?;
      final currentTextBox =
          _currentTextKey.currentContext?.findRenderObject() as RenderBox?;

      if (targetTextBox == null || currentTextBox == null) return;

      final targetTextPosition = targetTextBox.localToGlobal(Offset.zero);
      final currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

      final newDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      final newDiffTop = targetTextPosition.dy - currentTextPosition.dy;

      if (newDiffLeft != textDiffLeft || newDiffTop != textDiffTop) {
        setState(() {
          textDiffLeft = newDiffLeft;
          textDiffTop = newDiffTop;
        });
      }
    });
  }

  void _onSelectedItemChanged(int index) {
    final items = itemBlock.state.items;
    final selectedItem = items[index];

    itemBlock.add(ItemSelectChanged(itemId: selectedItem.id));

    final shouldLoadMore = index >= items.length - _endReachedThreshold;

    if (shouldLoadMore) {
      itemBlock.add(ItemLoadMoreStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildAppBar(),
        SizedBox(height: 9),
        _buildItemName(),
        SizedBox(height: 9),
        _buildItemSlider(),
      ],
    );
  }

  AppBar _buildAppBar() {
    return MainAppBar(
      // A placeholder for easily calculate the translate of the item name
      title: CurrentItemSelector((item) {
        _calculateItemNamePosition();

        return Text(
          item.name,
          key: _targetTextKey,
          style: const TextStyle(
            color: Colors.transparent,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        );
      }),
      rightIcon: IconButton(
          onPressed: () => AppNavigator.push(Routes.cart),
          icon: Icon(Icons.shopping_cart)
      )
    );
  }

  Widget _buildItemName() {
    var bgColor = Theme.of(context).colorScheme.onPrimaryContainer;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AnimatedBuilder(
              animation: slideController,
              builder: (_, __) {
                final value = slideController.value;

                return Transform.translate(
                  offset: Offset(textDiffLeft * value, textDiffTop * value),
                  child: CurrentItemSelector((item) {
                    return HeroText(
                      item.name,
                      textKey: _currentTextKey,
                      style: TextStyle(
                        color: bgColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 36 - (36 - 22) * value,
                        overflow: TextOverflow.ellipsis
                      ),
                    );
                  }),
                );
              },
            ),
          ),

// If you need to you can add fade animation for size or other information
          /*  SlideAnimation(
                animation: _horizontalSlideController,
                child: AnimatedFade(
                  animation: textFadeAnimation,
                  child: CurrentItemSelector((item) {
                    return HeroText(
                      item.size,
                      style: TextStyle(
                        color: bgColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    );
                  }),
                ),
              ),*/
        ],
      ),
    );
  }

  Widget _buildItemSlider() {
    final screenSize = MediaQuery.of(context).size;
    final sliderHeight = screenSize.height * 0.24;
    final pokeballSize = screenSize.height * 0.24;
    final itemSize = screenSize.height * 0.3;

    return AnimatedFade(
      animation: sliderFadeAnimation,
      child: SizedBox(
        width: screenSize.width,
        height: sliderHeight,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: RotationTransition(
                turns: rotateController,
                child: Image(
                  image: AppImages.pokeball,
                  width: pokeballSize,
                  height: pokeballSize,
                  color: Colors.white12,
                ),
              ),
            ),
            NumberOfItemsSelector((numberOfItems) {
              return PageView.builder(
                allowImplicitScrolling: true,
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: numberOfItems,
                onPageChanged: _onSelectedItemChanged,
                itemBuilder: (_, index) {
                  return ItemSelector(index, (item, selected) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Material(
                            color: AppColors.itemBackground,
                            child: Stack(
                                children: [
                                  ItemImage(
                                    item: item,
                                    size: Size.square(itemSize * 0.7),
                                    padding: EdgeInsets.symmetric(
                                      vertical: selected
                                          ? 0
                                          : screenSize.height * 0.04,
                                    ),
                                    useHero: selected,
                                  )
                                ],
                              ),

                          ),
                        ));
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
