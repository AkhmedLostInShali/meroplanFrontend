import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends StatefulWidget {
  final Model Function() create;
  final bool isManagingModel;
  final Widget child;

  const NotifierProvider(
      {Key? key,
      required this.create,
      required this.child,
      this.isManagingModel = true})
      : super(key: key);

  @override
  State<NotifierProvider> createState() => _NotifierProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            _InheritedNotifierProvider<Model>>()
        ?.widget;
    return widget is _InheritedNotifierProvider<Model> ? widget.model : null;
  }
}

class _NotifierProviderState<Model extends ChangeNotifier>
    extends State<NotifierProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  void dispose() {
    if (widget.isManagingModel) _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierProvider(model: _model, child: widget.child);
  }
}

class _InheritedNotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  const _InheritedNotifierProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static _InheritedNotifierProvider of(BuildContext context) {
    final _InheritedNotifierProvider? result = context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider>();
    assert(result != null, 'No NotifierProvider found in context');
    return result!;
  }
}
