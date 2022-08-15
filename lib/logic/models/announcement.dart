import 'dart:convert';

import 'package:flutter/painting.dart';

class Anouncement {
  Anouncement({
    required this.id,
    required this.link,
    required this.text,
    required this.bgColor,
  });
  final String id;
  final String link;
  final String text;
  final Color bgColor;

  Anouncement copyWith({
    String? id,
    String? link,
    String? text,
    Color? bgColor,
  }) =>
      Anouncement(
        id: id ?? this.id,
        link: link ?? this.link,
        text: text ?? this.text,
        bgColor: bgColor ?? this.bgColor,
      );

  factory Anouncement.fromJson(String str) =>
      Anouncement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Anouncement.fromMap(Map<String, dynamic> json) => Anouncement(
        id: json["id"],
        link: json["link"],
        text: json["text"],
        bgColor: Color(int.parse(json["bgColor"], radix: 16)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "link": link,
        "text": text,
        "bgColor": bgColor.toString().replaceAll(RegExp(r'[Color(0x|)]'), ''),
      };
}
