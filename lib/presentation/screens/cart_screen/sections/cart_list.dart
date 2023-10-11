part of '../cart_screen.dart';

class _CartList extends StatefulWidget {
  const _CartList();

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  CartBloc get cartBloc => context.read<CartBloc>();

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      cartBloc.add(const CartItemLoadStarted());
      _scrollKey.currentState?.innerController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollKey.currentState?.innerController.dispose();
    _scrollKey.currentState?.dispose();

    super.dispose();
  }

  void _onScroll() {
    final innerController = _scrollKey.currentState?.innerController;

    if (innerController == null || !innerController.hasClients) return;

    final thresholdReached = innerController.position.extentAfter <
        _endReachedThreshold;

    if (thresholdReached) {
      // Load more!
      cartBloc.add(CartLoadMoreStarted());
    }
  }

  Future _onRefresh() async {
    cartBloc.add(const CartItemLoadStarted());

    return cartBloc.stream.firstWhere((e) =>
    e.status != CartStateStatus.loading);
  }

  void _onItemDelete(CartItem cartItem) {
    cartBloc.add(CartItemDelete(cartItemId: cartItem.id));
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) =>
      [
        MainSliverAppBar(
          context: context,
        ),
      ],
      body: CartItemStateStatusSelector((status) {
        switch (status) {
          case CartStateStatus.loading:
            return _buildLoading();

          case CartStateStatus.loadSuccess:
          case CartStateStatus.loadMoreSuccess:
          case CartStateStatus.loadingMore:
            return _buildList();

          case CartStateStatus.loadFailure:
          case CartStateStatus.loadMoreFailure:
            return _buildError();

          default:
            return Container();
        }
      }),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Image(image: AppImages.model_9),
    );
  }

  Widget _buildList() {
    return CustomScrollView(
      slivers: [
        ItemRefreshControl(onRefresh: _onRefresh),
        SliverPadding(
          padding: const EdgeInsets.all(28),
          sliver: NumberOfCartItemsSelector((numberOfItems) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, index) {
                  return ItemSelector(index, (item, _) {
                    return ItemCard(
                      item,
                      onItemPress: () => _onItemPress(item),
                    );
                  });
                },
                childCount: numberOfItems,
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: ItemCanLoadMoreSelector((canLoadMore) {
            if (!canLoadMore) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: const EdgeInsets.only(bottom: 18),
              alignment: Alignment.center,
              child: const Image(image: AppImages.model_9),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        ItemRefreshControl(onRefresh: _onRefresh),
        SliverFillRemaining(
          child: Container(
            padding: const EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }
}
