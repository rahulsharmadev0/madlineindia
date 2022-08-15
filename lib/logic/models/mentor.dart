import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Mentor {
  Mentor({
    required this.id,
    required this.label,
    required this.pic,
    required this.name,
    required this.bgColor,
    required this.about,
    required this.link,
  });

  final String id;
  final String label;
  final String pic;
  final String name;
  final Color bgColor;
  final String about;
  final String link;

  Mentor copyWith({
    String? id,
    String? label,
    String? pic,
    String? name,
    Color? bgColor,
    String? about,
    String? link,
  }) =>
      Mentor(
        id: id ?? this.id,
        label: label ?? this.label,
        pic: pic ?? this.pic,
        name: name ?? this.name,
        bgColor: bgColor ?? this.bgColor,
        about: about ?? this.about,
        link: link ?? this.link,
      );

  factory Mentor.fromJson(String str) => Mentor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mentor.fromMap(Map<String, dynamic> json) => Mentor(
        id: json["id"],
        label: json["label"],
        pic: json["pic"],
        name: json["name"],
        bgColor: Color(int.parse(json["bgColor"], radix: 16)),
        about: json["about"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "label": label,
        "pic": pic,
        "name": name,
        "bgColor": bgColor.toString().replaceAll(RegExp(r'[Color(0x|)]'), ''),
        "about": about,
        "link": link,
      };
}
