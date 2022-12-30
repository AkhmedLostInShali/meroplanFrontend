import 'package:flutter/material.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/theme/my_text_styles.dart';
import 'package:hacaton/ui/widgets/entity_models/category_model.dart';
import 'package:hacaton/ui/widgets/entity_models/mero_event_model.dart';
import 'package:hacaton/ui/widgets/entity_views/categories_view.dart';
import 'package:hacaton/ui/widgets/entity_views/mero_event_view.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/shimmer.dart';
import 'package:provider/provider.dart';

class MainEventsScreenWidget extends StatefulWidget {
  const MainEventsScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainEventsScreenWidget> createState() => MainEventsScreenWidgetState();
}

class MainEventsScreenWidgetState extends State<MainEventsScreenWidget> {
  int? categoryId;
  final CategoryWidgetModel categoryWidgetModel = CategoryWidgetModel();
  final MeroEventWidgetModel eventWidgetModel = MeroEventWidgetModel();

  @override
  void initState() {
    super.initState();
    categoryWidgetModel.setupData();
  }

  void setCategory(int categoryID, String categoryName) {
    categoryWidgetModel.applyCategory(categoryID);
    final int? newCategoryID = categoryWidgetModel.lastParent;
    eventWidgetModel.setCategory(newCategoryID, categoryName);
    eventWidgetModel.setupData();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChangeNotifierProvider.value(
            value: categoryWidgetModel,
            child: ChangeNotifierProvider.value(
                value: eventWidgetModel, child: _PseudoAppBar()),
          ),
          Expanded(
            child: ChangeNotifierProvider.value(
                value: eventWidgetModel,
                child: ChangeNotifierProvider.value(
                    value: categoryWidgetModel,
                    child: const _CurrentContent())),
          ),
        ],
      ),
    );
  }
}

class _CurrentContent extends StatelessWidget {
  const _CurrentContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MeroEventWidgetModel eventWidgetModel =
        context.watch<MeroEventWidgetModel>();
    final CategoryWidgetModel categoryWidgetModel =
        context.read<CategoryWidgetModel>();
    return (eventWidgetModel.categoryChosen
        ? ChangeNotifierProvider.value(
            value: eventWidgetModel, child: const MeroEventViewWidget())
        : ChangeNotifierProvider.value(
            value: categoryWidgetModel, child: const CategoriesViewWidget()));
  }
}

class _PseudoAppBar extends StatelessWidget {
  final _searchBarTextController = TextEditingController();
  _PseudoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MeroEventWidgetModel model = context.watch<MeroEventWidgetModel>();
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: model.categoryChosen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                            onPressed: () {
                              model.setCategory(null, null);
                              CategoryWidgetModel catModel =
                                  context.read<CategoryWidgetModel>();
                              catModel
                                  .applyCategory(catModel.categories.last.id);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: MyColors.lavender,
                            )),Text(
                          model.categoryName,
                          style: MontserratTextStyles.titleFine24,
                        ),
                        const SizedBox(width: 40)
                      ]
                    )
                  : Text(
                      model.categoryName,
                      style: MontserratTextStyles.titleFine24,
                    ),
            ),
            (model.categoryChosen
                ? Container(
                    height: 64,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 4))
                    ]),
                    child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: _searchBarTextController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            letterSpacing: 1),
                        cursorColor: MyColors.lavender,
                        decoration: InputDecoration(
                            // isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            labelStyle: const TextStyle(
                                color: MyColors.gray,
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            label: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Поиск'),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ImageIcon(
                                      AssetImage(
                                          'assets/sliders-horizontal.png'),
                                      color: MyColors.lavender,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: MyColors.lightGray),
                                borderRadius: BorderRadius.circular(10)),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                        onSubmitted: (text) => model.searchEvents(text)),
                  )
                : const Text(
                    'Здесь ты точно найдешь, чем заняться',
                    style: MontserratTextStyles.eventInfo14,
                  ))
          ],
        ),
      ),
    );
  }
}

// class _PseudoAppBar extends StatelessWidget {
//   const _PseudoAppBar({
//     Key? key,
//     required this.retailerWidgetModel,
//     required TextEditingController searchBarTextController,
//     required this.categoryWidgetModel,
//   })  : _searchBarTextController = searchBarTextController,
//         super(key: key);
//
//   final RetailerWidgetModel retailerWidgetModel;
//   final TextEditingController _searchBarTextController;
//   final CategoryWidgetModel categoryWidgetModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         NotifierProvider(
//             model: retailerWidgetModel, child: const RetailersViewWidget()),
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 6),
//           child: SizedBox(
//             height: 36,
//             child: TextField(
//               onSubmitted: produc,
//                 textAlignVertical: TextAlignVertical.bottom,
//                 controller: _searchBarTextController,
//                 decoration: InputDecoration(
//                   label: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: const [
//                       Icon(Icons.search),
//                       Text('Поиск')
//                     ],
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 )),
//           ),
//         ),
//         NotifierProvider(
//             model: categoryWidgetModel,
//             child: const CategoriesViewWidget()),
//       ],
//     );
//   }
// }
