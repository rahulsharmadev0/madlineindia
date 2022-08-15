import 'package:flutter/material.dart';
import 'package:madlineindia/logic/repos/anouncement_repo.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class AlertBanner extends StatelessWidget {
  const AlertBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AnouncementRepo>();
    if (repo.isEmpty) {
      return const SizedBox();
    } else {
      final textTheme = Theme.of(context).textTheme;
      return ResponsiveLayout.byOnlyWidth(
        width: 800,
        small: buildChild(
          repo,
          context,
          textTheme.subtitle2!,
          isMobile: true,
        ),
        large: buildChild(
          repo,
          context,
          textTheme.headline6!,
          isMobile: false,
        ),
      );
    }
  }

  Container buildChild(
      AnouncementRepo repo, BuildContext context, TextStyle textstyle,
      {required bool isMobile}) {
    return Container(
      width: double.maxFinite,
      color: repo.data.bgColor,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/madlineindia.appspot.com/o/icons%2Falert.png?alt=media&token=a1e1ff22-45e8-46c6-8b8b-afa30ad054b1',
                height: 40),
          ),
          if (isMobile)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(repo.data.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textstyle),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 40),
              child:
                  SelectableText(repo.data.text, maxLines: 1, style: textstyle),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: const Text(
                'Check out',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => html.window.open(repo.data.link, '_blank'),
            ),
          )
        ],
      ),
    );
  }
}
