import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/category_api_client.dart';
import 'package:hacaton/domain/entities/categories/category.dart';
import 'package:hacaton/domain/entities/categories/category_response.dart';

class CategoryWidgetModel extends ChangeNotifier{
  final CategoryApiClient _apiClient = CategoryApiClient();
  final List<int> _parentsId = [];
  int? get lastParent => _parentsId.isEmpty ? null : _parentsId.last;
  final _categories = <MyCategory>[];
  List<MyCategory> get categories => List.unmodifiable(_categories);
  bool _isLoading = false;
  bool get isLoaded => !_isLoading;

  Future<void> setupData() async {
    if (_categories != []) {
      _loadCategories();
    }
  }

  void applyCategory(int parentsId) {
    if (lastParent == parentsId) {
      _parentsId.remove(parentsId);
    } else {
      _parentsId.add(parentsId);
    }
    reloadRetailers();
  }

  Future<void> reloadRetailers() async {
    _isLoading = true;
    notifyListeners();
    _categories.clear();
    setupData();
    // _loadCategories();
  }

  Future<void> _loadCategories() async {
    _isLoading = true;
    final CategoryResponse response = await _apiClient.getCategories(parentsId: lastParent);
    _categories.addAll(response.categories);
    _isLoading = false;
    notifyListeners();
  }

  void createCategory() => {};
}

// class CategoryModelProvider extends InheritedNotifier {
//   final CategoryWidgetModel model;
//
//   const CategoryModelProvider({
//     Key? key,
//     required this.model,
//     required Widget child,
//   }) : super(key: key, child: child, notifier: model);
//
//   static CategoryModelProvider of(BuildContext context) {
//     final CategoryModelProvider? result =
//     context.dependOnInheritedWidgetOfExactType<CategoryModelProvider>();
//     assert(result != null, 'No CategoryModelProvider found in context');
//     return result!;
//   }
//
//   static CategoryModelProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<CategoryModelProvider>();
//   }
//
//   static CategoryModelProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<CategoryModelProvider>()
//         ?.widget;
//
//     return widget is CategoryModelProvider ? widget : null;
//   }
//
// }
