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

const double _myHeight = 320;
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
              borderRadius: BorderRadius.all(Radius.zero),
              color: MyColors.black),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 190,
                  width: double.infinity,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                            event.name,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: MontserratTextStyles.eventName14,
                        ),
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  height: 18,
                                  child:
                                      SmallIcon(path: MyIcons.clock, white: true)),
                              const SizedBox(width: 8),
                              Text(
                                event.time,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: MontserratTextStyles.eventInfo14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6),
                      child: Row(
                        children: [
                          const SizedBox(
                              height: 18,
                              child:
                                  SmallIcon(path: MyIcons.mapPin, white: true)),
                          const SizedBox(width: 8),
                          Text(
                            event.address,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: MontserratTextStyles.eventInfo14,
                          ),
                          const Expanded(child: SizedBox()),
                          const SizedBox(
                              height: 18,
                              child: SmallIcon(
                                path: MyIcons.calendar,
                                white: true,
                              )),
                          const SizedBox(width: 8),
                          Text(
                            event.date,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: MontserratTextStyles.eventInfo14,
                          ),
                        ],
                      ),
                    ),
                      TextButton(
                        onPressed: () {
                          model.onMemberTap(context, index);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                color: model.events[index].isMembered
                                    ? MyColors.darkGray
                                    : Colors.transparent,
                                border: Border.all(
                                    color: MyColors.white, width: 2)),
                            child: model.events[index].isMembered
                                ? const Text('Не приду',
                                    style: MontserratTextStyles
                                        .eventSponsorsName16)
                                : const Text('Я приду',
                                    style: MontserratTextStyles
                                        .eventSponsorsName16,
                            textAlign: TextAlign.center,)
                        ),
                      ),
                  ],
                ),
              ]),
        )
      ]),
    );
  }
}

class FilterEventViewWidget extends StatelessWidget {
  const FilterEventViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterEventWidgetModel? model = context.watch<FilterEventWidgetModel?>();
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
                  ? _FilterEventsRowWidget(
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

class _FilterEventsRowWidget extends StatelessWidget {
  final int index;
  const _FilterEventsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FilterEventWidgetModel model = context.watch<FilterEventWidgetModel>();
    final MeroEvent event = model.events[index];
    return SizedBox(
      height: _myHeight,
      child: Stack(children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: _myHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.zero),
              color: MyColors.black),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 190,
                  width: double.infinity,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6),
                      child: Row(
                        children: [
                          Text(
                            event.name,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: MontserratTextStyles.eventName14,
                          ),
                          const Expanded(child: SizedBox()),
                          const SizedBox(
                              height: 18,
                              child:
                              SmallIcon(path: MyIcons.clock, white: true)),
                          const SizedBox(width: 8),
                          Text(
                            event.time,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: MontserratTextStyles.eventInfo14,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6),
                      child: Row(
                        children: [
                          const SizedBox(
                              height: 18,
                              child:
                              SmallIcon(path: MyIcons.mapPin, white: true)),
                          const SizedBox(width: 8),
                          Text(
                            event.address,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: MontserratTextStyles.eventInfo14,
                          ),
                          const Expanded(child: SizedBox()),
                          const SizedBox(
                              height: 18,
                              child: SmallIcon(
                                path: MyIcons.calendar,
                                white: true,
                              )),
                          const SizedBox(width: 8),
                          Text(
                            event.date,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: MontserratTextStyles.eventInfo14,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        model.onMemberTap(context, index);
                      },
                      child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                              color: model.events[index].isMembered
                                  ? MyColors.darkGray
                                  : Colors.transparent,
                              border: Border.all(
                                  color: MyColors.white, width: 2)),
                          child: model.events[index].isMembered
                              ? const Text('Не приду',
                              style: MontserratTextStyles
                                  .eventSponsorsName16)
                              : const Text('Я приду',
                            style: MontserratTextStyles
                                .eventSponsorsName16,
                            textAlign: TextAlign.center,)
                      ),
                    ),
                  ],
                ),
              ]),
        )
      ]),
    );
  }
}