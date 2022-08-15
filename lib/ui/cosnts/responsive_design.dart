// ignore: must_be_immutable,
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

double widthOf(context, double percentage) =>
    MediaQuery.of(context).size.width * percentage * .01;

double heightOf(context, double percentage) =>
    MediaQuery.of(context).size.height * percentage * .01;

class ResponsiveLayout extends StatelessWidget {
  final Widget small;
  final Widget? medium;
  final Widget large;
  final double? width;

  const ResponsiveLayout(
      {Key? key, required this.small, this.medium, required this.large})
      : width = null,
        super(key: key);
  const ResponsiveLayout.byOnlyWidth(
      {Key? key, this.width = 1200, required this.small, required this.large})
      : medium = null,
        super(key: key);

  Widget? _setlayoutSize(Size size) {
    if (size.height > 500 && size.width > 380) {
      return (size.width > size.height)
          ? (size.height / size.width) > .8
              ? medium
              : large
          : size.width / size.height < .8
              ? small
              : medium;
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return width != null
        ? screenSize.width < width!
            ? small
            : large
        : _setlayoutSize(screenSize) ?? large;
  }
}
