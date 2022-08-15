import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:madlineindia/logic/repos/details_repo.dart';
import 'package:madlineindia/ui/cosnts/apptheme.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class TopDisplayWidget extends StatelessWidget {
  const TopDisplayWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var repo = context.watch<DetailsRepo>();
    return ResponsiveLayout.byOnlyWidth(
      width: 800,
      small: forSmallScreen(context, repo),
      large: forLargeScreen(context, repo),
    );
  }

  Container forSmallScreen(context, DetailsRepo repo) {
    return Container(
      height: heightOf(context, 100),
      width: widthOf(context, 100),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/mobile_banner.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          const SizedBox(height: 1.5 * kToolbarHeight),
          SvgPicture.asset('assets/svg/mmtext.svg',
              width: widthOf(context, 90)),
          const Spacer(),
          _joinButton(repo),
          const SizedBox(height: kToolbarHeight),
        ],
      ),
    );
  }

  Column _joinButton(DetailsRepo repo) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                gradient: brandGradient,
                borderRadius: defaultBorderRadius,
                boxShadow: const [
                  BoxShadow(color: Colors.black54, blurRadius: 10)
                ]),
            child: repo.isEmpty
                ? SizedBox.square(dimension: 28, child: cIndicator())
                : InkResponse(
                    onTap: () {
                      var url = repo.data.enquiryLink;
                      html.window.open(
                          url.isNotEmpty ? url : 'http://madlineindia.com',
                          '_blank');
                    },
                    child: Text(
                      '  JOIN NOW  ',
                      style: style.headline5!.copyWith(color: Colors.white),
                    ),
                  ),
          ),
          GestureDetector(
              child: Lottie.asset('assets/lottie/scrolldown.json',
                  height: kToolbarHeight),
              onTap: () => pageController.animateToPage(2,
                  duration: defaultDuration, curve: defaultCurve)),
        ],
      );

  Container forLargeScreen(context, DetailsRepo repo) {
    return Container(
      height: heightOf(context, 100) - kToolbarHeight,
      decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/banner.jpg'),
            fit: BoxFit.cover,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: SvgPicture.asset('assets/svg/text.svg',
                height: heightOf(context, 50)),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _joinButton(repo),
              )),
        ],
      ),
    );
  }
}
