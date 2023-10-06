// import 'package:flutter/material.dart';
//
// import '../models/app_shimmer_type.dart';
// import '../ui_components/shimmer_placeholder_widget.dart';
// import '../ui_components/shimmer_proportional_placeholder_widget.dart';
// import '../ui_components/shimmer_random_placeholder_widget.dart';
// import 'app_shimmer.dart';
//
// class AppShimmerText extends StatelessWidget {
//   const AppShimmerText(
//     this.text, {
//     this.style,
//     this.maxLines,
//     this.overflow,
//     this.alignment = Alignment.centerLeft,
//     this.type,
//     this.textAlign,
//     this.baseColor,
//     this.highlightColor,
//     this.borderRadius,
//     this.textHeightBehavior,
//     this.child,
//     Key? key,
//   }) : super(key: key);
//
//   final TextStyle? style;
//   final String? text;
//   final int? maxLines;
//   final TextOverflow? overflow;
//   final AppShimmerType? type;
//   final AlignmentGeometry alignment;
//   final TextAlign? textAlign;
//   final Color? baseColor;
//   final Color? highlightColor;
//   final double? borderRadius;
//   final TextHeightBehavior? textHeightBehavior;
//   final Widget? child;
//
//   @override
//   Widget build(BuildContext context) => AppShimmer(
//         showShimmer: text == null,
//         alignment: alignment,
//         fadeTransition: false,
//         baseColor: baseColor,
//         highlightColor: highlightColor,
//         child: _buildChild(context),
//       );
//
//   Widget _buildChild(BuildContext context) {
//     if (child != null) {
//       return child!;
//     }
//
//     if (text != null) {
//       return Text(text!,
//           style: style,
//           maxLines: maxLines,
//           overflow: overflow,
//           textAlign: textAlign,
//           textHeightBehavior: textHeightBehavior);
//     }
//
//     final type = this.type ?? AppShimmerType.random();
//
//     if (type is AppShimmerTypeFixed) {
//       return ShimmerPlaceholderWidget(
//         placeholderText: type.placeholderText,
//         style: style,
//         maxLines: maxLines,
//         overflow: overflow,
//         alignment: alignment,
//         borderRadius: borderRadius,
//       );
//     }
//
//     if (type is AppShimmerTypeRandom) {
//       return ShimmerRandomPlaceholderWidget(
//         placeholderText: type.placeholderText,
//         style: style,
//         maxLines: maxLines,
//         overflow: overflow,
//         shimmerTypeRandom: type,
//         alignment: alignment,
//       );
//     }
//
//     if (type is AppShimmerTypeProportional) {
//       return ShimmerProportionalPlaceholderWidget(
//         leadingFlex: type.leadingFlex,
//         trailingFlex: type.trailingFlex,
//         placeholderText: type.placeholderText,
//         overflow: overflow,
//         maxLines: maxLines,
//         alignment: alignment,
//         style: style,
//         borderRadius: borderRadius,
//       );
//     }
//
//     return Container();
//   }
// }
