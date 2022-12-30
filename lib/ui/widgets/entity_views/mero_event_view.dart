import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/mero_events/mero_event.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/theme/my_text_styles.dart';
import 'package:hacaton/ui/widgets/entity_models/mero_event_model.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/fancy_icon.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/shimmer.dart';
import 'package:provider/provider.dart';

const double _myHeight = 367;
const double _borderRadius = 15;

class MeroEventViewWidget extends StatelessWidget {
  const MeroEventViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MeroEventWidgetModel? model = context.watch<MeroEventWidgetModel?>();
    if (model == null) return const SizedBox.shrink();
    final int itemCount = model.isLoaded ? model.events.length : 2;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: itemCount,
      padding: const EdgeInsets.only(top: 0),
      itemBuilder: (BuildContext context, int index) {
        if (index >= itemCount) {
          return const SizedBox(
            height: _myHeight,
          );
        }
        model.scrolledToEventAtIndex(index);
        return ShimmerLoading(
            isLoading: !model.isLoaded,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: model.isLoaded
                  ? _MeroEventsRowWidget(
                      index: index,
                    )
                  : Container(
                      clipBehavior: Clip.hardEdge,
                      height: _myHeight,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        color: Colors.white,
                      )),
            ));
      },
    );
  }
}

class _MeroEventsRowWidget extends StatelessWidget {
  final int index;
  const _MeroEventsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MeroEventWidgetModel model = context.watch<MeroEventWidgetModel>();
    final MeroEvent event = model.events[index];
    return SizedBox(
      height: _myHeight,
      child: Stack(children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: _myHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(_borderRadius)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 190,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(_borderRadius)),
                  child: CachedNetworkImage(
                    cacheManager: null,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    placeholder: (context, url) => Transform.scale(
                        scaleX: 0.24,
                        scaleY: 0.5,
                        child: const CircularProgressIndicator(
                          color: MyColors.lavender,
                        )),
                    imageUrl: '$serverRootPath${event.imagePath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      event.name,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: MontserratTextStyles.eventName14,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                    child: Row(
                      children: [
                        const SizedBox(
                            height: 18,
                            child: SmallIcon(path: MyIcons.calendar, black: true,)),
                        const SizedBox(width: 8),
                        Text(
                          event.date,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: MontserratTextStyles.eventInfo14,
                        ),
                        const Expanded(child: SizedBox()),
                        const SizedBox(
                            height: 18, child: SmallIcon(path: MyIcons.clock, black: true)),
                        const SizedBox(width: 8),
                        Text(
                          event.time,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: MontserratTextStyles.eventInfo14,
                        ),
                        const SizedBox(width: 40)
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                    child: Row(
                      children: [
                        const SizedBox(
                            height: 18, child: SmallIcon(path: MyIcons.mapPin, black: true)),
                        const SizedBox(width: 8),
                        Text(
                          event.address,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: MontserratTextStyles.eventInfo14,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 36,
                            width: 36,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.semiGray),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    '$serverRootPath${event.sponsorsImagePath}',
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () =>
                                {model.onSponsorTap(context, index)},
                            child: Text(event.sponsorsName,
                                style:
                                    MontserratTextStyles.eventSponsorsName16)),
                        const Expanded(child: SizedBox()),
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: IconButton(
                            onPressed: () {
                              model.onMemberTap(context, index);
                            },
                            icon: model.events[index].isMembered
                                ? const Icon(Icons.person_remove_alt_1_outlined)
                                : const Icon(Icons.person_add_alt_outlined),
                            color: model.events[index].isMembered
                                ? MyColors.lavender
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 12,
                          child: Text(
                            event.members.toString(),
                            style: MontserratTextStyles.eventInfo14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
