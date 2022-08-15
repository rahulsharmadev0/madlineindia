import 'package:flutter/material.dart';
import 'package:ico/ico.dart';
import 'package:madlineindia/logic/repos/details_repo.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import '../../../cosnts/responsive_design.dart';

class ContectUs extends StatelessWidget {
  const ContectUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    var repo = context.watch<DetailsRepo>();
    return Center(
      child: Container(
        width: widthOf(context, 80),
        height: 230,
        margin: const EdgeInsets.symmetric(vertical: 32),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 0.5, color: Colors.black26))),
        child: ResponsiveLayout(
          small: Column(children: [
            part_01(theme, TextAlign.center, theme.headline4!),
            part_02(repo, theme, theme.headline4!)
          ]),
          large: Row(children: [
            part_01(theme, TextAlign.start, theme.headline3!),
            part_02(repo, theme, theme.headline3!)
          ]),
        ),
      ),
    );
  }

  Expanded part_01(
      TextTheme theme, TextAlign textAlign, TextStyle headingStyle) {
    return Expanded(
      child: Center(
        child: SelectableText.rich(
            textAlign: textAlign,
            TextSpan(
                text: 'Talk to our Best Mentor!\n',
                style: headingStyle,
                children: [
                  TextSpan(
                      text: 'Get a free counselling session from our experts',
                      style: theme.bodyText2)
                ])),
      ),
    );
  }

  Expanded part_02(DetailsRepo repo, TextTheme theme, headingStyle) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Ico.phone_outline), Text('Contect Number')],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!repo.isEmpty)
                  TextButton(
                      onPressed: () => html.window
                          .open('tel:${repo.data.guidNumber}', '_blank'),
                      child: ShaderMask(
                        shaderCallback: ((bounds) => brandGradient
                            .createShader(Offset.zero & bounds.size)),
                        child: Text('+91-${repo.data.guidNumber}',
                            style: headingStyle!.copyWith(color: Colors.white)),
                      )),
                ShaderMask(
                    shaderCallback: ((bounds) =>
                        brandGradient.createShader(Offset.zero & bounds.size)),
                    child: const Text(' or let us call you!',
                        style: TextStyle(color: Colors.white)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
