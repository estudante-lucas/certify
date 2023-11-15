import 'package:flutter/material.dart';

class SnapshotData<T> extends StatelessWidget {
  const SnapshotData({
    Key? key,
    required this.snapshot,
    required this.data,
    required this.noData,
  }) : super(key: key);

  final AsyncSnapshot<T> snapshot;
  final Widget Function(T data) data;
  final Widget noData;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData && snapshot.data != null && (snapshot.data as List).isNotEmpty) {
      return data(snapshot.data as T);
    }
    return noData;
  }
}
