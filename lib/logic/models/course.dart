import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Course {
  Course({
    required this.id,
    required this.title,
    required this.colors,
    required this.joinLink,
    required this.image,
    required this.bgSvg,
    required this.shortDescription,
    required this.mentor,
    required this.mentorPic,
    required this.softwares,
    required this.duration,
    required this.longDescription,
  });

  final String id;
  final String title;
  final List<Color> colors;
  final String joinLink;
  final String image;
  final String bgSvg;
  final String shortDescription;
  final String mentor;
  final String mentorPic;
  final String softwares;
  final String duration;
  final String longDescription;

  Course copyWith({
    String? id,
    String? title,
    List<Color>? colors,
    String? joinLink,
    String? image,
    String? bgSvg,
    String? shortDescription,
    String? mentor,
    String? mentorPic,
    String? softwares,
    String? duration,
    String? longDescription,
  }) =>
      Course(
        id: id ?? this.id,
        title: title ?? this.title,
        colors: colors ?? this.colors,
        joinLink: joinLink ?? this.joinLink,
        image: image ?? this.image,
        bgSvg: bgSvg ?? this.bgSvg,
        shortDescription: shortDescription ?? this.shortDescription,
        mentor: mentor ?? this.mentor,
        mentorPic: mentorPic ?? this.mentorPic,
        softwares: softwares ?? this.softwares,
        duration: duration ?? this.duration,
        longDescription: longDescription ?? this.longDescription,
      );

  factory Course.fromJson(String str) => Course.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        colors: List<Color>.from(
            json["colors"].map((x) => Color(int.parse(x, radix: 16)))),
        joinLink: json["joinLink"],
        image: json["image"],
        bgSvg: json["bgSvg"],
        shortDescription: json["shortDescription"],
        mentor: json["mentor"],
        mentorPic: json["mentorPic"],
        softwares: json["softwares"],
        duration: json["duration"],
        longDescription: json["longDescription"].replaceAll('\\n', '\n'),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "colors": List<String>.from(colors
            .map((x) => x.toString().replaceAll(RegExp(r'[Color(0x|)]'), ''))),
        "joinLink": joinLink,
        "image": image,
        "bgSvg": bgSvg,
        "shortDescription": shortDescription,
        "mentor": mentor,
        "mentorPic": mentorPic,
        "softwares": softwares,
        "duration": duration,
        "longDescription": longDescription.replaceAll('\n', '\\n'),
      };
}
