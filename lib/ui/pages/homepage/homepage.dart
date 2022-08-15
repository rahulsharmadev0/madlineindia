// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madlineindia/logic/repos/anouncement_repo.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:madlineindia/ui/pages/homepage/components/bottom_about_widget.dart';
import 'package:madlineindia/ui/pages/homepage/components/feature_course_widget.dart';
import 'package:madlineindia/ui/pages/homepage/components/success_stories.dart';
import 'package:madlineindia/ui/widgets/alert_banner.dart';
import 'package:madlineindia/ui/widgets/custom_appbar.dart';
import 'package:madlineindia/ui/widgets/customdrawer.dart';
import 'package:provider/provider.dart';
import 'components/contect_us_widget.dart';
import 'components/top_display_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widthOf(context, 100) < 600
          ? AppBar(
              centerTitle: true, title: Image.asset('assets/logo/main.png'))
          : PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(pageController: pageController)),
      drawer: widthOf(context, 100) > 600
          ? null
          : CustomDrawer(pageController: pageController),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(controller: pageController, children: [
              TopDisplayWidget(pageController: pageController),
              FeatureCourse(pageController),
              SuccessStories(),
              ContectUs(),
              BottomAbout()
            ]),
          ),
          if (!context.watch<AnouncementRepo>().isEmpty)
            Positioned(top: 0, right: 0, left: 0, child: const AlertBanner()),
        ],
      ),
    );
  }
}
