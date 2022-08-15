import 'package:flutter/material.dart';

const defaultCurve = Curves.fastLinearToSlowEaseIn;
const defaultDuration = Duration(milliseconds: 800);

get defaultBorderRadius => BorderRadius.circular(1000);
get defaultBorderRadius10 => BorderRadius.circular(10);

const textSec = Colors.black;
const alertBannerColor = Color(0xffffd42a);

const brandGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xff4a04f7), Color(0xffff659d), Color(0xffff6f29)],
);

const course = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xff4a04f7), Color(0xffff659d), Color(0xffff6f29)],
);

cIndicator() =>
    const Center(child: CircularProgressIndicator(color: Colors.white));

scaffoldcIndicator() =>
    const Scaffold(body: Center(child: CircularProgressIndicator()));

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
