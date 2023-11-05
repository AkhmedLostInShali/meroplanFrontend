import 'package:flutter/material.dart';
import 'package:hacaton/ui/theme/my_colors.dart';

class MyIcons {
  static const String home = 'assets/home.png';

  static const String friends = 'assets/friends.png';

  static const String search = 'assets/search.png';

  static const String addCircle = 'assets/plus-circle.png';

  static const String user = 'assets/user.png';

  static const String calendar = 'assets/calendar.png';

  static const String clock = 'assets/clock.png';

  static const String mapPin = 'assets/map-pin.png';

}

class SmallIcon extends StatelessWidget {
  final String path;
  final bool white;

  const SmallIcon({Key? key, required this.path, required this.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      Expanded(
        child: ClipRect(
          child: ImageIcon(
            AssetImage(path),
            color: white ? MyColors.white : MyColors.semiGray,
          ),
        ),
      ),
    ]);
  }
}

class ActiveSmallIcon extends StatelessWidget {
  final String path;

  const ActiveSmallIcon({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
            height: 40,
            width: 40,
            child: ImageIcon(
              AssetImage(path),
              color: MyColors.white,
            )),
      ),
    ]);
  }
}

class ActiveCircleIcon extends StatelessWidget {
  final String path;

  const ActiveCircleIcon({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
            height: 50,
            width: 50,
            child: ImageIcon(
              AssetImage(path),
              color: Colors.white,
            )),
      ),
    ]);
  }
}

