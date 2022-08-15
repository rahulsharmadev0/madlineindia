import 'dart:js';

import 'package:flutter/material.dart';
import 'package:madlineindia/ui/cosnts/apptheme.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:madlineindia/ui/pages/mentor_profile/mentor_profile.dart';
import '../cosnts/default_values.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  const CustomDrawer({Key? key, required this.pageController})
      : super(key: key);

  actionButton({required VoidCallback onTap, required String title}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListTile(
          onTap: () {
            navigation.pop();
            onTap();
          },
          title: Text(
            title,
            style: TextStyle(
                color: AppThemeData.lightThemeData.colorScheme.primary),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Drawer(
      width: widthOf(context, 50),
      backgroundColor: Colors.black,
      child: ListView(children: [
        Image.asset('assets/logo/main.png'),
        actionButton(
          title: 'Home',
          onTap: () => pageController.animateToPage(0,
              curve: defaultCurve, duration: defaultDuration),
        ),
        actionButton(
          title: 'Courses',
          onTap: () => pageController.animateToPage(1,
              curve: defaultCurve, duration: defaultDuration),
        ),
        actionButton(
          title: 'Mentors',
          onTap: () => navigation.push(MaterialPageRoute(
            builder: (_) => MentorProfile(),
          )),
        ),
        actionButton(
          title: 'Placements',
          onTap: () => pageController.animateToPage(4,
              curve: defaultCurve, duration: defaultDuration),
        ),
        actionButton(
          title: 'Contect',
          onTap: () => pageController.animateToPage(6,
              curve: defaultCurve, duration: defaultDuration),
        ),
      ]));
}
