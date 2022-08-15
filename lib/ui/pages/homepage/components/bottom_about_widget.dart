// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:madlineindia/logic/models/details.dart';
import 'package:madlineindia/logic/repos/details_repo.dart';
import 'package:madlineindia/ui/cosnts/apptheme.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:provider/provider.dart';

class BottomAbout extends StatelessWidget {
  const BottomAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!context.watch<DetailsRepo>().isEmpty) {
      final data = context.watch<DetailsRepo>().data;
      return Material(
        textStyle: Theme.of(context).textTheme.bodyText1,
        child: Container(
          color: Colors.black,
          width: double.maxFinite,
          height: widthOf(context, 100) < 800 ? null : 350,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ResponsiveLayout.byOnlyWidth(
            width: 800,
            small: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: list_01.sublist(0, 4)),
                  Column(children: list_02(data)..removeAt(7))
                ]),
            large: SizedBox(
              width: widthOf(context, 80),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: list_01),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: list_02(data))
                  ]),
            ),
          ),
        ),
      );
    } else {
      return cIndicator();
    }
  }

  List<Widget> get list_01 => <Widget>[
        Image.asset(
          'assets/logo/main.png',
          height: 42,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(height: 16),
        const Text('Privacy Policy | Terms of Service'),
        const Text('Copyright 2022 - Madlines Pvt. Ltd.'),
        const Spacer(),
        const Text("Copyright © 2022 Madlines Pvt. Ltd"),
      ];

  List<Widget> list_02(Details data) => <Widget>[
        const Text('FOLLOW US ON'),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: data.smChannels
                  .map((e) => TextButton(
                      onPressed: () => html.window.open(e.link, '_blank'),
                      child: Image.network(e.image,
                          height: 30, fit: BoxFit.fitHeight)))
                  .toList()),
        ),
        const Text('CONTACT US'),
        const Text('Madlines Toll Free Number'),
        TextButton(
            child: Text('+91-${data.madlineNumber}'),
            onPressed: () =>
                html.window.open('tel:${data.guidNumber}', '_blank')),
        const Text('\nMadlines Contact Email'),
        TextButton(
            child: Text(data.madlineEmail),
            onPressed: () => html.window.open(
                'mailto:${data.madlineEmail}?subject=Query&body=Dear Medline Team%20',
                '_blank')),
        const Spacer(),
        InkWell(
          child: const Text("⚒️ Designed & Developed by rahulsharmadev"),
          onTap: () => html.window.open('http://rsprofile.web.app', '_self'),
        ),
      ];
}
