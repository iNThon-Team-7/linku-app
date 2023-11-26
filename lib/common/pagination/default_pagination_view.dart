import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:linku/common/pagination/base_pagination_provider.dart';

typedef ItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);

class DefaultPaginationView<T> extends ConsumerStatefulWidget {
  final StateNotifierProvider<BasePaginationStateNotifier, List<T>> provider;
  final ItemBuilder<T> itemBuilder;
  const DefaultPaginationView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DefaultPaginationViewState<T>();
}

class _DefaultPaginationViewState<T>
    extends ConsumerState<DefaultPaginationView<T>> {
  final PagingController<int, T> _controller =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _controller.addPageRequestListener((pageKey) {
      ref.read(widget.provider.notifier).fetch(
            controller: _controller,
            page: pageKey,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}
