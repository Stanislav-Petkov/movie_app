// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../../app_extensions.dart';
// import '../../assets.dart';
// // import '../../lib_shimmer/views/app_shimmer.dart';
// import '../app/config/app_constants.dart';
// import '../extensions/error_model_extensions.dart';
// // import '../models/error/error_model.dart';
// // import 'app_error_card_widget.dart';
// import 'app_shimmer.dart';
//
// class AppNetworkImage extends StatelessWidget {
//
//   const AppNetworkImage({
//     Key? key,
//     required this.imageUrl,
//     this.fit = BoxFit.cover,
//     this.showError = false,
//   }) : super(key: key);
//
//   final String imageUrl;
//   final BoxFit fit;
//   final bool showError;
//
//   static String url = 'https://picsum.photos/250?image=9';
//
//   @override
//   Widget build(BuildContext context) =>
//   Image.network(url);
//       // CachedNetworkImage(
//       //     imageUrl: imageUrl,
//       //     fit: fit,
//       //     placeholder: (context, url) => AppShimmer(
//       //       showShimmer: true,
//       //       child: Container(
//       //         color: Colors.white//context.designSystem.colors.mediumWhite,
//       //       ),
//       //     ),
//       //     errorWidget: (context, url, error) => Container(
//       //       alignment: Alignment.center,
//       //       color: Colors.red,//context.designSystem.colors.redLight,
//       //       child: _buildErrorContent(context, error),
//       //     ),
//       //   );
//
//   Widget _buildErrorContent(BuildContext context, dynamic error) =>
//       const Text('UI ERROR Image');
//       // showError
//       // ? AppErrorCardWidget(
//       //     backgroundColor: context.designSystem.colors.redLight,
//       //     retryButtonVisible: false,
//       //     error: (error is Exception)
//       //         ? error.asErrorModel()
//       //         : ErrorGenericModel(I18nErrorKeys.errorOccurred).asErrorModel(),
//       //   )
//       // : const SizedBox.shrink();
// }
