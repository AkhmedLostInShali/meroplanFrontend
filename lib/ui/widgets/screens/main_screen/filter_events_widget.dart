import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/theme/my_text_styles.dart';
import 'package:hacaton/ui/widgets/entity_models/category_model.dart';
import 'package:hacaton/ui/widgets/entity_models/mero_event_model.dart';
import 'package:hacaton/ui/widgets/entity_views/categories_view.dart';
import 'package:hacaton/ui/widgets/entity_views/mero_event_view.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/shimmer.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class FilterEventsScreenWidget extends StatefulWidget {
  const FilterEventsScreenWidget({Key? key}) : super(key: key);

  @override
  State<FilterEventsScreenWidget> createState() =>
      FilterEventsScreenWidgetState();
}

class FilterEventsScreenWidgetState extends State<FilterEventsScreenWidget> {
  // final CategoryWidgetModel categoryWidgetModel = CategoryWidgetModel();
  final FilterEventWidgetModel eventWidgetModel = FilterEventWidgetModel();

  @override
  void initState() {
    super.initState();
    // eventWidgetModel.setupData();
    // categoryWidgetModel.setupData();
  }

  // void setCategory(int categoryID, String categoryName) {
  //   categoryWidgetModel.applyCategory(categoryID);
  //   final int? newCategoryID = categoryWidgetModel.lastParent;
  //   eventWidgetModel.setCategory(newCategoryID, categoryName);
  //   eventWidgetModel.setupData();
  // }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChangeNotifierProvider.value(
              value: eventWidgetModel, child: const _PseudoAppBar()),
          Expanded(
            child: ChangeNotifierProvider.value(
                value: eventWidgetModel, child: const _CurrentContent()),
          )
          // ChangeNotifierProvider.value(
          //   value: categoryWidgetModel,
          //   child: ChangeNotifierProvider.value(
          //       value: eventWidgetModel, child: _PseudoAppBar()),
          // ),
          // Expanded(
          //   child: ChangeNotifierProvider.value(
          //       value: eventWidgetModel,
          //       child: ChangeNotifierProvider.value(
          //           value: categoryWidgetModel,
          //           child: const _CurrentContent())),
          // ),
        ],
      ),
    );
  }
}

class _CurrentContent extends StatelessWidget {
  const _CurrentContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterEventWidgetModel eventWidgetModel =
        context.watch<FilterEventWidgetModel>();
    // final CategoryWidgetModel categoryWidgetModel =
    //     context.read<CategoryWidgetModel>();
    return (
            // eventWidgetModel.categoryChosen ?
            ChangeNotifierProvider.value(
                value: eventWidgetModel, child: const FilterEventViewWidget())
        // : ChangeNotifierProvider.value(
        //     value: categoryWidgetModel, child: const CategoriesViewWidget())
        );
  }
}

class _PseudoAppBar extends StatelessWidget {
  const _PseudoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: MyColors.black,
        child: const FilterSearchBar(),
      ),
    );
  }
}

class FilterSearchBar extends StatefulWidget {
  const FilterSearchBar({super.key});

  @override
  State<FilterSearchBar> createState() => _FilterSearchBarState();
}

class _FilterSearchBarState extends State<FilterSearchBar> {
  @override
  Widget build(BuildContext context) {
    final bool filterIsOpened =
        context.select<FilterEventWidgetModel, bool>((model) => model.isOpened);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchBar(),
          const SizedBox(
            height: 20,
          ),
          filterIsOpened ? FilterBars() : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchBarTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FilterEventWidgetModel model = context.read<FilterEventWidgetModel>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 40,
      child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          controller: _searchBarTextController,
          style: MontserratTextStyles.inputTextStyle,
          cursorColor: MyColors.white,
          decoration: InputDecoration(
              // isDense: true,
              filled: true,
              fillColor: MyColors.gray,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              labelStyle: const TextStyle(
                  color: MyColors.lightGray,
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              label: const Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Text('Поиск'),
              ),
              suffixIcon: InkWell(
                  onTap: () => model.switchOpenState(),
                  child: ImageIcon(
                    AssetImage(model.isOpened
                        ? 'assets/cross.png'
                        : 'assets/filter_slides.png'),
                  )),
              // hintText: 'Поиск',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(style: BorderStyle.none),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelBehavior: FloatingLabelBehavior.never),
          onSubmitted: (text) => model.searchEvents(text)),
    );
  }
}

class FilterBars extends StatefulWidget {
  const FilterBars({
    super.key,
  });

  @override
  State<FilterBars> createState() => _FilterBarsState();
}

enum SortingFilter { basic, byDate }

class _FilterBarsState extends State<FilterBars> {
  late final TextEditingController _addressFilterTextController;
  late final TextEditingController _firstDateFilterTextController;
  late final TextEditingController _lastDateFilterTextController;
  late final TextEditingController _minMemberFilterTextController;
  late final TextEditingController _maxMemberFilterTextController;

  @override
  void initState() {
    super.initState();
    _addressFilterTextController = TextEditingController();
    _firstDateFilterTextController = TextEditingController();
    _lastDateFilterTextController = TextEditingController();
    _minMemberFilterTextController = TextEditingController();
    _maxMemberFilterTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final FilterEventWidgetModel model =
        context.watch<FilterEventWidgetModel>();
    _addressFilterTextController.text = model.address;
    _firstDateFilterTextController.text = model.firstDate;
    _lastDateFilterTextController.text = model.lastDate;
    _minMemberFilterTextController.text = model.minMember;
    _maxMemberFilterTextController.text = model.maxMember;
    SortingFilter? sortingFilter = model.isBaseSorting ? SortingFilter.basic : SortingFilter.byDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CategoryButton(model: model, text: 'Бизнес', categoryId: '3'),
            CategoryButton(model: model, text: 'Спорт', categoryId: '1'),
            CategoryButton(model: model, text: 'Творчество', categoryId: '2'),
            CategoryButton(model: model, text: 'IT', categoryId: '4'),
          ],
        ),
        Row(
          children: [
            CategoryButton(model: model, text: 'Путешествия', categoryId: '6'),
            CategoryButton(model: model, text: 'Игры', categoryId: '7'),
            CategoryButton(model: model, text: 'Кулинария', categoryId: '5'),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Место',
            style: MontserratTextStyles.categoryTitle20,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          child: TextField(
              controller: _addressFilterTextController,
              textAlignVertical: TextAlignVertical.bottom,
              style: MontserratTextStyles.inputTextStyle,
              cursorColor: MyColors.white,
              decoration: InputDecoration(
                  // isDense: true,
                  filled: true,
                  fillColor: MyColors.gray,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  labelStyle: const TextStyle(
                      color: MyColors.lightGray,
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  label: const Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Text('Город, район'),
                  ),
                  // hintText: 'Город, район',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(style: BorderStyle.none),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          style: BorderStyle.solid, color: MyColors.gray),
                      borderRadius: BorderRadius.circular(10)),
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              onChanged: (text) => model.setAddressFilter(text)),
        ),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Период',
            style: MontserratTextStyles.categoryTitle20,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                    controller: _firstDateFilterTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: '##.##.##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy)
                    ],
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.center,
                    style: MontserratTextStyles.inputTextStyle,
                    cursorColor: MyColors.white,
                    decoration: InputDecoration(
                        // isDense: true,
                        filled: true,
                        fillColor: MyColors.gray,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        labelStyle: const TextStyle(
                          color: MyColors.lightGray,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        label: const Center(child: Text('ДД.ММ.ГГ')),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(style: BorderStyle.none),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid, color: MyColors.gray),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    onChanged: (text) => model.setFirstDateFilter(text)),
              ),
              const SizedBox(width: 24),
              const Text('—'),
              const SizedBox(width: 24),
              Expanded(
                child: TextField(
                    controller: _lastDateFilterTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskTextInputFormatter(
                          mask: '##.##.##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy)
                    ],
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.center,
                    style: MontserratTextStyles.inputTextStyle,
                    cursorColor: MyColors.white,
                    decoration: InputDecoration(
                        // isDense: true,
                        filled: true,
                        fillColor: MyColors.gray,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        labelStyle: const TextStyle(
                          color: MyColors.lightGray,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        label: const Center(child: Text('ДД.ММ.ГГ')),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(style: BorderStyle.none),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid, color: MyColors.gray),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    onChanged: (text) => model.setLastDateFilter(text)),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Количество участников',
            style: MontserratTextStyles.categoryTitle20,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          title: const Text('По умолчанию', style: MontserratTextStyles.eventSponsorsName16,),
          leading: Radio<SortingFilter>(
            value: SortingFilter.basic,
            activeColor: MyColors.white,
            groupValue: sortingFilter,
            onChanged: (SortingFilter? value) {
              setState(() {
                sortingFilter = value;
              });
              model.setSortingFilter('basic');
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          title: const Text('По дате', style: MontserratTextStyles.eventSponsorsName16),
          leading: Radio<SortingFilter>(
            value: SortingFilter.byDate,
            activeColor: MyColors.white,
            groupValue: sortingFilter,
            onChanged: (SortingFilter? value) {
              setState(() {
                sortingFilter = value;
              });
              model.setSortingFilter('date');
            },
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Количество участников',
            style: MontserratTextStyles.categoryTitle20,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                    controller: _minMemberFilterTextController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.center,
                    style: MontserratTextStyles.inputTextStyle,
                    cursorColor: MyColors.white,
                    decoration: InputDecoration(
                        // isDense: true,
                        filled: true,
                        fillColor: MyColors.gray,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        labelStyle: const TextStyle(
                          color: MyColors.lightGray,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        label: const Center(child: Text('от')),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(style: BorderStyle.none),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid, color: MyColors.gray),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    onChanged: (text) => model.setMinMemberFilter(text)),
              ),
              const SizedBox(width: 24),
              const Text('—'),
              const SizedBox(width: 24),
              Expanded(
                child: TextField(
                    controller: _maxMemberFilterTextController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.center,
                    style: MontserratTextStyles.inputTextStyle,
                    cursorColor: MyColors.white,
                    decoration: InputDecoration(
                        // isDense: true,
                        filled: true,
                        fillColor: MyColors.gray,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        labelStyle: const TextStyle(
                          color: MyColors.lightGray,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        label: const Center(child: Text('до')),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(style: BorderStyle.none),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid, color: MyColors.gray),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    onChanged: (text) => model.setMaxMemberFilter(text)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {super.key,
      required this.model,
      required this.text,
      required this.categoryId});

  final FilterEventWidgetModel model;
  final String text;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    Color mainColor =
        model.category == categoryId ? MyColors.white : MyColors.gray;
    return TextButton(
        onPressed: () => model.setCategoryFilter(categoryId),
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: mainColor),
        ),
        child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color: Colors.transparent,
                border: Border.all(color: mainColor, width: 2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                text,
                style: MontserratTextStyles.eventInfo14,
              ),
            )));
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
