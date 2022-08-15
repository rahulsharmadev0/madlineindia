import 'package:flutter/material.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:madlineindia/ui/pages/mentor_profile/mentor_profile.dart';
import '../cosnts/default_values.dart';

class CustomAppBar extends StatelessWidget {
  final PageController pageController;
  const CustomAppBar({Key? key, required this.pageController})
      : super(key: key);

  actionButton({required VoidCallback onTap, required String title}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextButton(
          onPressed: onTap,
          child: Text(title),
        ),
      );

  @override
  Widget build(BuildContext context) => AppBar(
        title: Image.asset('assets/logo/main.png'),
        actions: [
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
        ],
      );
}
