import 'dart:ui';

import 'package:flutter/material.dart';

ImageFilter commonBlurFilter = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0, tileMode: TileMode.clamp);

BoxDecoration circleDecor = BoxDecoration(
  border: BoxBorder.all(color: Colors.grey, width: 1),
  borderRadius: BorderRadius.all(Radius.circular(64))
);

class TextTag extends StatelessWidget {
  final String text;
  final String? iconAsset;

  const TextTag({super.key, required this.text, this.iconAsset});

  @override
  Widget build(BuildContext context) {
    List<Widget> tagContents = [];
    if (iconAsset != null) {
      tagContents.add(Icon(Icons.abc, size: 12));
    }
    tagContents.add(Text(text));

    return BackdropFilter(
      filter: ImageFilter.blur(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.all(color: Colors.grey, width: 1),
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 0)
          )],
          borderRadius: BorderRadius.all(Radius.circular(32))
        ),
        child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 4), child: Wrap(children: tagContents)),
      ),
    );
  }
}

class BottomBarCircularContainer extends StatelessWidget {
  final Widget child;

  const BottomBarCircularContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(
      child: Container(
        decoration: circleDecor,
        child: ClipOval(
          child: BackdropFilter(filter: commonBlurFilter, child: child),
        ),
      ),
    ));
  }
}

