import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hacaton/domain/api_clients/general_api_client.dart';
import 'package:hacaton/domain/entities/categories/category.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/theme/my_text_styles.dart';
import 'package:hacaton/ui/widgets/entity_models/category_model.dart';
import 'package:hacaton/ui/widgets/fancy_widgets/shimmer.dart';
import 'package:hacaton/ui/widgets/screens/main_screen/main_events_widget.dart';
import 'package:provider/provider.dart';

// class CategoriesViewWidget extends StatelessWidget {
//   const CategoriesViewWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CategoryWidgetModel? model = context.watch<CategoryWidgetModel?>();
//     if (model == null) return const SizedBox.shrink();
//     return ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemCount: model.isLoaded ? model.categories.length : 6,
//       itemBuilder: (BuildContext context, int index) {
//         return ShimmerLoading(
//           isLoading: !model.isLoaded,
//           child: Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             child: model.isLoaded
//                 ? _CategoryRowWidget(
//                     index: index,
//                   )
//                 : Container(
//                     width: 328,
//                     height: 106,
//                     decoration: const BoxDecoration(
//                         color: MyColors.semiGray,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ))),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _CategoryRowWidget extends StatelessWidget {
//   final int index;
//   const _CategoryRowWidget({Key? key, required this.index}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CategoryWidgetModel model = context.watch<CategoryWidgetModel>();
//     final MyCategory category = model.categories[index];
//     return Stack(children: [
//       Container(
//           width: 328,
//           height: 106,
//           child: ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             child: CachedNetworkImage(
//               cacheManager: null,
//               errorWidget: (context, url, error) => const Icon(Icons.error),
//               placeholder: (context, url) => Transform.scale(
//                   scaleX: 0.16,
//                   scaleY: 0.5,
//                   child: const CircularProgressIndicator(
//                     color: MyColors.lavender,
//                   )),
//               imageUrl: '$serverRootPath${category.imagePath}',
//               fit: BoxFit.cover,
//             ),
//           )),
//       Container(
//         width: 328,
//         height: 106,
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.3),
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           category.name,
//           textAlign: TextAlign.center,
//           style: MontserratTextStyles.categoryTitle20,
//         ),
//       ),
//       SizedBox(
//         width: 328,
//         height: 106,
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               onTap: () => context
//                   .findAncestorStateOfType<MainEventsScreenWidgetState>()
//                   ?.setCategory(category.id, category.name)),
//         ),
//       )
//     ]);
//   }
// }
