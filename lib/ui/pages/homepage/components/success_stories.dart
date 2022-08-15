import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:madlineindia/logic/models/details.dart';
import 'package:madlineindia/logic/repos/details_repo.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:provider/provider.dart';

class SuccessStories extends StatelessWidget {
  const SuccessStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repo = context.watch<DetailsRepo>();

    if (repo.isEmpty) {
      return cIndicator();
    } else {
      var theme = Theme.of(context).textTheme;
      return ResponsiveLayout(
        small: childWidget(context, repo, theme, theme.headline4, .8),
        medium: childWidget(context, repo, theme, theme.headline3, .5),
        large: childWidget(context, repo, theme, theme.headline2, .25),
      );
    }
  }

  Column childWidget(BuildContext context, DetailsRepo repo, TextTheme theme,
      headingStyle, double viewportFraction) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child:
            SelectableText('Our students are placed at', style: headingStyle),
      ),
      CarouselSlider.builder(
          itemCount: repo.data.brands.length,
          itemBuilder: (context, index, realIndex) =>
              Image.network(repo.data.brands[index].image),
          options: CarouselOptions(
              autoPlayCurve: Curves.linear,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayInterval: const Duration(seconds: 2),
              autoPlay: true,
              height: 80,
              viewportFraction: viewportFraction)),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 64, 0, 32),
        child:
            SelectableText('Success stories at Madlines', style: headingStyle),
      ),
      _autoSliderForStudents(
          repo.data.successStudents, theme, viewportFraction),
      const SizedBox(height: 32),
      _autoSliderForStudents(repo.data.successStudents, theme, viewportFraction,
          reverse: true),
    ]);
  }

  CarouselSlider _autoSliderForStudents(
      List<SuccessStudent> data, TextTheme theme, double viewportFraction,
      {bool reverse = false}) {
    return CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (context, index, realIndex) => Card(
              elevation: 8,
              shape:
                  RoundedRectangleBorder(borderRadius: defaultBorderRadius10),
              clipBehavior: Clip.hardEdge,
              child: SizedBox.square(
                dimension: 300,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        data[index].image,
                        height: 230,
                        width: 300,
                        fit: BoxFit.fitWidth,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].label,
                                    style: theme.headline6!.copyWith(
                                        fontWeight: FontWeight.normal)),
                                Text(data[index].name)
                              ]),
                        ),
                      )
                    ]),
              ),
            ),
        options: CarouselOptions(
          reverse: reverse,
          autoPlay: true,
          aspectRatio: 1.2,
          height: 300,
          autoPlayInterval: const Duration(seconds: 2),
          viewportFraction: viewportFraction,
        ));
  }
}
