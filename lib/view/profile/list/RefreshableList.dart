import 'package:flutter/material.dart';

class RefreshableList<T> extends StatelessWidget {
  final List<T> items;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext, T) itemBuilder;

  const RefreshableList({
    Key? key,
    required this.items,
    required this.onRefresh,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(context, items[index]),
      ),
    );
  }
}
