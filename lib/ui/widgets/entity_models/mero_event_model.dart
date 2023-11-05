import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/mero_event_api_client.dart';
import 'package:hacaton/domain/entities/mero_events/mero_event.dart';
import 'package:hacaton/ui/navigation/main_navigation.dart';

class MeroEventWidgetModel extends ChangeNotifier {
  final MeroEventApiClient _apiClient = MeroEventApiClient();
  final _events = <MeroEvent>[];
  List<MeroEvent> get events => List.unmodifiable(_events);
  late int _currentPage;
  late int _totalPages;
  bool _isLoading = false;
  bool get isLoaded => !_isLoading;
  // int? _categoryID;
  // String? _categoryName;
  // String get categoryName => _categoryName != null ? _categoryName! : 'Meroplan';
  // bool get categoryChosen => _categoryID != null;
  String? _searchQuery;

  Future<void> setupData() async {
    if (_events != []) {
      _currentPage = 0;
      _totalPages = 1;
      _loadEvents();
    }
  }

  Future<void> _loadEvents() async {
    if (_isLoading || _currentPage >= _totalPages) return;
    _isLoading = true;
    notifyListeners();
    final int nextPage = _currentPage + 1;

    try {
      final response = await _apiClient.getEvents(
          page: nextPage, searchQuery: _searchQuery);
      _events.addAll(response.meroEvents);
      _totalPages = response.totalPages;
      _currentPage = nextPage;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> reloadEvents() async {
    _events.clear();
    setupData();
    // _loadProducts();
  }

  void scrolledToEventAtIndex(int index) {
    if (index < _events.length - 1) return;
    _loadEvents();
  }

  void createEvent() => {};

  // void setCategory(int? categoryID, String? categoryName) {
  //   _categoryID = categoryID;
  //   _categoryName = categoryName;
  //   reloadEvents();
  // }

  void searchEvents(String searchQuery) {
    _searchQuery = searchQuery;
    reloadEvents();
  }

  void onSponsorTap(BuildContext context, int index) {
    String sponsorID = _events[index].sponsorsId;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.userDetails, arguments: sponsorID);
  }

  void onMemberTap(BuildContext context, int index) {
    String eventsID = _events[index].id;
    if (_events[index].isMembered) {
      _events[index].members -= 1;
    }
    else {_events[index].members += 1;}
    _events[index].isMembered = !_events[index].isMembered;
    _apiClient.memberEvent(
        eventsID: eventsID, isMembered: _events[index].isMembered);
    notifyListeners();
  }

  // void onProductTap(BuildContext context, int index) {
  //   final id = _products[index].id;
  //   Navigator.of(context).pushNamed(
  //     MainNavigationRouteNames.productDetails,
  //     arguments: id,
  //   )
  // }
}


class FilterEventWidgetModel extends MeroEventWidgetModel {
  String? _firstDateFilter;
  String get firstDate => _firstDateFilter ?? '';
  String? _lastDateFilter;
  String get lastDate => _lastDateFilter ?? '';
  String? _addressFilter;
  String get address => _addressFilter ?? '';
  String? _minMemberFilter;
  String get minMember => _minMemberFilter ?? '';
  String? _maxMemberFilter;
  String get maxMember => _maxMemberFilter ?? '';
  String? _sortingFilter = 'basic';
  bool get isBaseSorting => _sortingFilter == 'basic';
  bool _isOpened = true;
  bool get isOpened => _isOpened;
  String? _categoryFilter;
  String? get category => _categoryFilter;

  @override
  Future<void> setupData() async {
    if (_events != []) {
      _currentPage = 0;
      _totalPages = 1;
      _loadEvents();
    }
  }

  void switchOpenState() {
    _isOpened = !_isOpened;
    notifyListeners();
  }

  void setCategoryFilter(String categoryFilter) {
    _categoryFilter = _categoryFilter == categoryFilter ? null : categoryFilter;
    notifyListeners();
  }

  void setFirstDateFilter(String? firstDateFilter) {
    _firstDateFilter = firstDateFilter;
    // notifyListeners();
  }

  void setLastDateFilter(String? lastDateFilter) {
    _lastDateFilter = lastDateFilter;
    // notifyListeners();
  }

  void setAddressFilter(String? addressFilter) {
    _addressFilter = addressFilter;
    // notifyListeners();
  }

  void setMinMemberFilter(String? minMemberFilter) {
    _minMemberFilter = minMemberFilter;
    // notifyListeners();
  }

  void setMaxMemberFilter(String? maxMemberFilter) {
    _maxMemberFilter = maxMemberFilter;
    // notifyListeners();
  }

  void setSortingFilter(String? sortingFilter) {
    _sortingFilter = sortingFilter;
    // notifyListeners();
  }

  @override
  void searchEvents(String searchQuery) {
    _searchQuery = searchQuery;
    reloadEvents();
  }

  @override
  Future<void> _loadEvents() async {
    if (_isLoading || _currentPage >= _totalPages) return;
    _isLoading = true;
    notifyListeners();
    final int nextPage = _currentPage + 1;

    try {
      final response = await _apiClient.getFilteredEvents(
          page: nextPage, searchQuery: _searchQuery,
          firstDate: _firstDateFilter, lastDate: _lastDateFilter,
          minMember: _minMemberFilter, maxMember: _maxMemberFilter,
          address: _addressFilter, category: _categoryFilter);
      _events.addAll(response.meroEvents);
      _totalPages = response.totalPages;
      _currentPage = nextPage;
      _isLoading = false;
      _isOpened = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  @override
  Future<void> reloadEvents() async {
    _events.clear();
    setupData();
    // _loadProducts();
  }

}

// class ProductModelProvider extends InheritedNotifier {
//   final ProductWidgetModel model;
//
//   const ProductModelProvider({
//     Key? key,
//     required this.model,
//     required Widget child,
//   }) : super(key: key, child: child, notifier: model);
//
//   static ProductModelProvider of(BuildContext context) {
//     final ProductModelProvider? result =
//         context.dependOnInheritedWidgetOfExactType<ProductModelProvider>();
//     assert(result != null, 'No ProductModelProvider found in context');
//     return result!;
//   }
//
//   static ProductModelProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<ProductModelProvider>();
//   }
//
//   static ProductModelProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<ProductModelProvider>()
//         ?.widget;
//
//     return widget is ProductModelProvider ? widget : null;
//   }
//
// }
