import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madlineindia/logic/models/course.dart';
import 'dart:html' as html;

import 'package:madlineindia/ui/cosnts/responsive_design.dart';

class CourseDetail extends StatelessWidget {
  final Course course;
  const CourseDetail({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
      width: double.maxFinite,
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: course.colors)),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.string(course.bgSvg,
              color: Colors.white10,
              width: widthOf(context, 100),
              fit: BoxFit.fill),
          SizedBox(
            width: 1000,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: theme.headline3!.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Course by: ${course.mentor}  |  Duration: ${course.duration}',
                  style: theme.headline6!.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Markdown(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  data: course.longDescription,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                      .copyWith(
                          h3: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                          tableBody: const TextStyle(color: Colors.white),
                          p: const TextStyle(color: Colors.white),
                          listBullet: const TextStyle(color: Colors.white)),

                  /// Handle the link. The [href] in the callback contains information
                  /// from the link. The url_launcher package or other similar package
                  /// can be used to execute the link.
                  onTapLink: (text, href, title) async {
                    if (href != null) html.window.open(href, '_blank');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
