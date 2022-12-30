// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:hacaton/ui/theme/my_colors.dart';
//
// class UserDetailsWidget extends StatefulWidget {
//   final int productID;
//   const UserDetailsWidget({Key? key, required this.productID})
//       : super(key: key);
//
//   @override
//   State<UserDetailsWidget> createState() => UserDetailsWidgetState();
// }
//
// class UserDetailsWidgetState extends State<UserDetailsWidget> {
//   late final UserDetailsWidgetModel productDetailsWidgetModel;
//   late final User? product;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     NotifierProvider.read<UserDetailsWidgetModel>(context)?.loadProduct();
//   }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   productDetailsWidgetModel = ProductDetailsWidgetModel(widget.productID);
//   //   productDetailsWidgetModel.loadProduct();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _ProductNameBarWidget(),
//         backgroundColor: MyColors.darkGray,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: const <Widget>[
//             _ProductThumbnailWidget(),
//             _ProductInfoWidget()
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ProductThumbnailWidget extends StatelessWidget {
//   const _ProductThumbnailWidget({Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final product = NotifierProvider.watch<ProductDetailsWidgetModel>(context)?.product;
//     if (product == null) return const SizedBox.shrink();
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(4),
//           )),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.all(Radius.circular(4)),
//         child: CachedNetworkImage(
//           placeholder: (context, url) => const CircularProgressIndicator(),
//           imageUrl: '$serverRootPath${product.imagePath}',
//         ),
//       ),
//     );
//   }
// }
//
// class _ProductInfoWidget extends StatelessWidget {
//   const _ProductInfoWidget({Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final product = NotifierProvider.watch<ProductDetailsWidgetModel>(context)?.product;
//     if (product == null) return const SizedBox.shrink();
//     return Column(
//       children: <Widget>[
//         Material(
//           elevation: 10,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               color: MyColors.darkGray,
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             child: Text(product.name, style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24
//             ),),
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class _ProductNameBarWidget extends StatelessWidget {
//   const _ProductNameBarWidget({Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final product = NotifierProvider.watch<ProductDetailsWidgetModel>(context)?.product;
//     if (product == null) return const SizedBox.shrink();
//     return Text(product.name, style: const TextStyle(
//           color: Colors.white,
//           fontSize: 24
//       ),
//       );
//   }
// }