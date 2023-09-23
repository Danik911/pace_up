import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:pace_up/data/repositories/item_repository.dart';
import 'package:pace_up/states/item/item_event.dart';
import 'package:pace_up/states/item/item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  static const int itemsPerPage = 20;

  final ItemRepository _itemRepository;

  ItemBloc(this._itemRepository) : super(const ItemState.initial()) {
    on<ItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<ItemLoadMoreStarted>(
      _onLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<ItemSelectChanged>(_onSelectChanged);
  }

  void _onLoadStarted(ItemLoadStarted event, Emitter<ItemState> emit) async {
    try {
      emit(state.asLoading());

      final items = event.loadAll
          ? await _itemRepository.getAllItems()
          : await _itemRepository.getItemsByPage(page: 1, limit: itemsPerPage);

      final canLoadMore = items.length >= itemsPerPage;

      emit(state.asLoadSuccess(items, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onLoadMoreStarted(ItemLoadMoreStarted event, Emitter<ItemState> emit) async {
    try {
      if (!state.canLoadMore) return;

      emit(state.asLoadingMore());

      final items = await _itemRepository.getItemsByPage(
        page: state.page + 1,
        limit: itemsPerPage,
      );

      final canLoadMore = items.length >= itemsPerPage;

      emit(state.asLoadMoreSuccess(items, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadMoreFailure(e));
    }
  }

  void _onSelectChanged(ItemSelectChanged event, Emitter<ItemState> emit) async {
    try {
      final itemIndex = state.items.indexWhere(
            (item) => item.id == event.itemId,
      );

      if (itemIndex < 0 || itemIndex >= state.items.length) return;

      final item = await _itemRepository.getItem(event.itemId);

      if (item == null) return;

      emit(state.copyWith(
        items: state.items..setAll(itemIndex, [item]),
        selectedItemIndex: itemIndex,
      ));
    } on Exception catch (e) {
      emit(state.asLoadMoreFailure(e));
    }
  }
}
