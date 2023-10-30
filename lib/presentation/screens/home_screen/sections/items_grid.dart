part of '../home_screen.dart';


class _ItemsGrid extends StatefulWidget {
  const _ItemsGrid();

  @override
  _ItemsGridState createState() => _ItemsGridState();
}

class _ItemsGridState extends State<_ItemsGrid> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  ItemBloc get itemBloc => context.read<ItemBloc>();

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      itemBloc.add(const ItemLoadStarted());
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
      itemBloc.add(ItemLoadMoreStarted());
    }
  }

  Future _onRefresh() async {
    itemBloc.add(const ItemLoadStarted());

    return itemBloc.stream.firstWhere((e) =>
    e.status != ItemStateStatus.loading);
  }

  void _onItemPress(Item item) {
    itemBloc.add(ItemSelectChanged(itemId: item.id));

    AppNavigator.push(Routes.details, item);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) =>
      [
        MainSliverAppBar(
          context: context,
          true,
          "Items"
        ),
      ],
      body: ItemStateStatusSelector((status) {
        switch (status) {
          case ItemStateStatus.loading:
            return _buildLoading();

          case ItemStateStatus.loadSuccess:
          case ItemStateStatus.loadMoreSuccess:
          case ItemStateStatus.loadingMore:
            return _buildGrid();

          case ItemStateStatus.loadFailure:
          case ItemStateStatus.loadMoreFailure:
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

  Widget _buildGrid() {
    return CustomScrollView(
      slivers: [
        ItemRefreshControl(onRefresh: _onRefresh),
        SliverPadding(
          padding: const EdgeInsets.all(28),
          sliver: NumberOfItemsSelector((numberOfItems) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
                mainAxisSpacing: 10,
              ),
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
