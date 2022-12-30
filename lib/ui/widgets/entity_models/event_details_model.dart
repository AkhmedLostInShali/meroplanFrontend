// import 'package:flutter/material.dart';
//
// class EventDetailsWidgetModel extends ChangeNotifier {
//   final EventApiClient _apiClient = EventApiClient();
//   Event? _event;
//   Event? get event => _event;
//   final String _eventId;
//   late final String _locale;
//   bool _isLoading = false;
//
//   EventDetailsWidgetModel(this._productId);
//
//   // Future<void> setupData() async {
//   //   _loadProduct();
//   // }
//
//   Future<void> setupLocale(BuildContext context) async {
//     final locale = Localizations.localeOf(context).toLanguageTag();
//     if (_locale == locale) return;
//     _locale = _locale;
//     await loadProduct();
//   }
//
//
//   Future<void> loadProduct() async {
//     final response = await _apiClient.getEvent(
//       eventID: _eventId,
//     );
//     _event = response.userDetails;
//     _isLoading = false;
//     notifyListeners();
//   }
// }