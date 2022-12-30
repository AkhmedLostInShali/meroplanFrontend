import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/user/my_profile.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/theme/my_text_styles.dart';
import 'package:hacaton/ui/widgets/entity_models/user_page_model.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/shimmer.dart';
import 'package:provider/provider.dart';
class UserPageWidget extends StatefulWidget {
  const UserPageWidget({Key? key}) : super(key: key);

  @override
  State<UserPageWidget> createState() => _UserPageWidgetState();
}

class _UserPageWidgetState extends State<UserPageWidget> {
  final UserPageModel model = UserPageModel();

  @override
  void initState() {
    super.initState();
    model.setupData();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(
                (MediaQuery.of(context).size.width * 0.05).roundToDouble()),
            child: ChangeNotifierProvider.value(
                value: model, child: const _UserCardWidget()),
          ),
          const SizedBox(height: 40, child: _ProfileSettingsButton()),
          SizedBox(
              height:
                  (MediaQuery.of(context).size.width * 0.05).roundToDouble()),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: MyColors.ghostWhiteGray,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 0,
                ),
                ChangeNotifierProvider.value(
                    value: model, child: const _LogOutButton())
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class _UserCardWidget extends StatelessWidget {
  const _UserCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserPageModel? model = context.watch<UserPageModel?>();
    if (model == null) {
      return const SizedBox.shrink();
    }
    return Shimmer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          _UserAvatarWidget(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: _NameTitleBar(),
          ),
        ],
      ),
    );
  }
}

class _UserAvatarWidget extends StatelessWidget {
  const _UserAvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserPageModel model = context.watch<UserPageModel>();
    final MyProfile? profile = model.myProfile;
    return ShimmerLoading(
        isLoading: profile == null,
        child: Container(
            height: (MediaQuery.of(context).size.width * 0.3).roundToDouble(),
            width: (MediaQuery.of(context).size.width * 0.3).roundToDouble(),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: MyColors.ghostDarkGray),
            child: (profile == null)
                ? null
                : ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: '$serverRootPath${profile.imagePath}',
                      fit: BoxFit.cover,
                    ),
                  )));
  }
}

class _NameTitleBar extends StatelessWidget {
  const _NameTitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserPageModel model = context.watch<UserPageModel>();
    final MyProfile? profile = model.myProfile;
    final bool isLoading = profile == null || !model.isLoaded;
    return ShimmerLoading(
        isLoading: isLoading,
        child: Container(
            height: 32,
            width: isLoading
                ? (MediaQuery.of(context).size.width * 0.3).roundToDouble()
                : null,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: profile == null ? MyColors.ghostDarkGray : null),
            child: isLoading
                ? null
                : ((model.myProfile?.name != '')
                    ? Text(
                        model.myProfile!.name!,
                        style: MontserratTextStyles.fine32,
                      )
                    : const _AddNameButton())));
  }
}

class _AddNameButton extends StatelessWidget {
  const _AddNameButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final UserPageModel model = context.watch<UserPageModel>();
    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Ваше имя',
                style: MontserratTextStyles.fine16,
              ),
              content: TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Введите ваше имя'),
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      await model.changeName(context, controller.text);
                    },
                    icon: const Icon(Icons.check))
              ],
            ));

    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MyColors.lavender),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))))),
        onPressed: () {
          openDialog();
        },
        child: const Text(
          'Ввести имя',
          style: MontserratTextStyles.fine16,
        ));
  }
}

class _RedirectingButton extends StatelessWidget {
  const _RedirectingButton({
    Key? key,
    required this.text,
    required this.routeName,
  }) : super(key: key);

  final String text;

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: (MediaQuery.of(context).size.width * 0.6).roundToDouble(),
      child: OutlinedButton(
          onPressed: () {
            // Navigator.of(context).pushNamed('/$routeName');
          },
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all(MyColors.ghostDarkGray),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))))),
          child: Text(
            text,
            style: MontserratTextStyles.fine12,
          )),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserPageModel userPageModel = context.read<UserPageModel>();
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(MyColors.ghostDarkGray),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))))),
        onPressed: () {
          userPageModel.logOut(context);
        },
        child: const Text(
          'Выйти',
          style: MontserratTextStyles.fine12,
        ),
      ),
    );
  }
}

class _ProfileSettingsButton extends StatelessWidget {
  const _ProfileSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          // Navigator.of(context).pushNamed('/profile_settings');
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(MyColors.lavender),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))))),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width * 0.45).roundToDouble(),
          child: const Text(
            'Настройки профиля',
            textAlign: TextAlign.center,
            style: MontserratTextStyles.fine12,
          ),
        ));
  }
}
