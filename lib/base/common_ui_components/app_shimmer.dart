// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../app_extensions.dart';
// import '../../base/common_transitions/app_fade_transition.dart';
//
// class AppShimmer extends StatelessWidget {
//   const AppShimmer({
//     required this.child,
//     required this.showShimmer,
//     this.alignment = Alignment.centerLeft,
//     this.radius = 0,
//     this.fadeTransition = true,
//     this.baseColor,
//     this.highlightColor,
//     Key? key,
//   }) : super(key: key);
//
//   final Widget child;
//   final bool showShimmer;
//   final AlignmentGeometry? alignment;
//   final double radius;
//
//   final Color? baseColor;
//   final Color? highlightColor;
//
//   /// Use the default fade transition.
//   ///
//   /// If `false` the fade and size transition will be used instead.
//   final bool fadeTransition;
//
//   static const shimmerContainerKey = Key('shimmer');
//
//   @override
//   Widget build(BuildContext context) => AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         transitionBuilder: (child, animation) =>
//             fadeTransition || child.key == AppShimmer.shimmerContainerKey
//                 ? FadeTransition(
//                     opacity: animation,
//                     child: child,
//                   )
//                 : appFadeTransition(animation: animation, child: child),
//         child: _buildChild(context),
//       );
//
//   Widget _buildChild(BuildContext context) {
//     if (showShimmer) {
//       return Container(
//         key: AppShimmer.shimmerContainerKey,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(radius),
//           ),
//         ),
//         alignment: alignment,
//         child: Shimmer.fromColors(
//           baseColor: Colors.amberAccent,//baseColor ?? context.designSystem.colors.shimmerBaseColor,
//           highlightColor: Colors.green,
//           // highlightColor ??
//           //     context.designSystem.colors.shimmerHighlightColor,
//           child: child,
//         ),
//       );
//     }
//
//     if (alignment != null) {
//       return Align(
//         alignment: alignment!,
//         child: child,
//       );
//     }
//
//     return child;
//   }
// }
