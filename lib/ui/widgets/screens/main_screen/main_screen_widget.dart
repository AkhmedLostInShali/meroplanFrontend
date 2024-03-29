import 'package:flutter/material.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/theme/my_text_styles.dart';
import 'package:hacaton/ui/widgets/entity_models/user_page_model.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/fancy_icon.dart';
import 'package:hacaton/ui/widgets/screens/main_screen/filter_events_widget.dart';
import 'package:hacaton/ui/widgets/screens/main_screen/main_events_widget.dart';
import 'package:hacaton/ui/widgets/screens/main_screen/user_page_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  final UserPageModel userPageModel = UserPageModel();

  int _selectedTab = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    MainEventsScreenWidget(),
    FilterEventsScreenWidget(),
    // Text(
    //   'Index 2: Add Event',
    //   style: optionStyle,
    // ),
    Text(
      'Index 2: Add Event',
      style: optionStyle,
    ),
    Text(
      'Index 3: My Events',
      style: optionStyle,
    ),
    UserPageWidget(),
  ];
  void _onItemTapped(int index) {
    switch (index) {
      case 2:
        showModal(context);
        break;
    }
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: MyColors.black,
        shadowColor: Colors.transparent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image(image: AssetImage('assets/tut.png')),
            SizedBox(width: 8,),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text('ты точно найдешь, чем заняться', style: MontserratTextStyles.eventSponsorsName16),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        iconSize: 40,
        items: const [
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 40,
                child: SmallIcon(
                  path: MyIcons.home, white: false,
                ),
              ),
              activeIcon: SizedBox(
                height: 40,
                width: 40,
                child: ActiveSmallIcon(
                  path: MyIcons.home,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 40,
                child: SmallIcon(
                  path: MyIcons.search, white: false,
                ),
              ),
              activeIcon: SizedBox(
                height: 40,
                width: 40,
                child: ActiveSmallIcon(
                  path: MyIcons.search,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 40,
                width: 40,
                child: SmallIcon(
                  path: MyIcons.addCircle, white: false,
                ),
              ),
              activeIcon: SizedBox(
                height: 40,
                width: 40,
                child: ActiveCircleIcon(
                  path: MyIcons.addCircle,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 40,
                child: SmallIcon(
                  path: MyIcons.calendar, white: false,
                ),
              ),
              activeIcon: SizedBox(
                height: 40,
                width: 40,
                child: ActiveSmallIcon(
                  path: MyIcons.calendar,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 40,
                child: SmallIcon(
                  path: MyIcons.user, white: false,
                ),
              ),
              activeIcon: SizedBox(
                height: 40,
                width: 40,
                child: ActiveSmallIcon(
                  path: MyIcons.user,
                ),
              ),
              label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: MyColors.white,
        unselectedItemColor: MyColors.semiGray,
        backgroundColor: MyColors.black,
      ),
      body: Center(
        child: IndexedStack(
          index: _selectedTab,
          children: _widgetOptions,
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
