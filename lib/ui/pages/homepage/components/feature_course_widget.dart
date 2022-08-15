import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madlineindia/logic/repos/coursesrepo.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:provider/provider.dart';
import '../../../../logic/models/course.dart';
import 'course_detail_widget.dart';

class FeatureCourse extends StatelessWidget {
  final PageController pageController;
  const FeatureCourse(
    this.pageController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repo = context.watch<CoursesRepo>();
    if (repo.isEmpty) {
      return cIndicator();
    } else {
      var list = List.generate(repo.list!.length, (i) {
        return InkWell(
          onTap: () async => await pageController.animateToPage(i + 2,
              duration: defaultDuration, curve: defaultCurve),
          child: _CourseDisplayCard(course: repo.list![i]),
        );
      }).toList();
      return ResponsiveLayout.byOnlyWidth(
        width: 1100,
        small: smallChild(context, list, repo),
        large: largeChild(context, list, repo),
      );
    }
  }

  Container smallChild(
      BuildContext context, List<InkWell> list, CoursesRepo repo) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: brandGradient.colors
                    .map((e) => e.withOpacity(0.1))
                    .toList())),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: SelectableText('Featured Courses',
                  style: Theme.of(context).textTheme.headline4),
            ),
            CarouselSlider.builder(
              options: CarouselOptions(
                  aspectRatio: 2.0,
                  height: 500,
                  viewportFraction: 1,
                  autoPlay: true),
              itemCount: list.length,
              itemBuilder: (context, index, realIndex) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: list[index],
              ),
            ),
            const SizedBox(height: 28),
            if (!repo.isEmpty)
              for (var e in repo.list!) CourseDetail(course: e)
          ],
        ));
  }

  Widget largeChild(
      BuildContext context, List<InkWell> list, CoursesRepo repo) {
    return Column(
      children: [
        Container(
            height: heightOf(context, 100) - kToolbarHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: brandGradient.colors
                        .map((e) => e.withOpacity(0.1))
                        .toList())),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectableText('Featured Courses',
                    style: Theme.of(context).textTheme.headline2),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    height: 500,
                    viewportFraction: 1,
                  ),
                  itemCount: (list.length / 2).round(),
                  itemBuilder: (context, index, realIndex) {
                    final int first = index * 2;
                    final int second = first + 1;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [first, second]
                          .map((idx) => (idx < list.length)
                              ? list[idx]
                              : const Offstage())
                          .toList(),
                    );
                  },
                ),
              ],
            )),
        if (!repo.isEmpty)
          for (var e in repo.list!) CourseDetail(course: e)
      ],
    );
  }
}

class _CourseDisplayCard extends StatelessWidget {
  final Course course;
  const _CourseDisplayCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.05,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: defaultBorderRadius10,
              color: course.colors.first.withOpacity(0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 185,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: course.colors)),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.25,
                        child:
                            SvgPicture.string(course.bgSvg, fit: BoxFit.fill),
                      ),
                      Positioned(
                          left: 25,
                          bottom: 20,
                          child: Image.network(
                            course.image,
                            height: 150,
                          )),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/logo/main.png',
                            height: 24,
                          )),
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.title,
                                  style: GoogleFonts.raleway(
                                      color: course.colors.first,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "COURSE BY ${course.mentor}",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: defaultBorderRadius),
                            child: Image.network(course.mentorPic,
                                fit: BoxFit.fill),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      SelectableText(course.shortDescription),
                      const SizedBox(height: 16),
                      ShaderMask(
                          shaderCallback: (bounds) =>
                              LinearGradient(colors: course.colors)
                                  .createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                          child: SelectableText(
                              'Software Covered :${course.softwares}',
                              style: const TextStyle(color: Colors.white))),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(course.duration),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
