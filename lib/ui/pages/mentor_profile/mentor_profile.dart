import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:madlineindia/logic/repos/anouncement_repo.dart';
import 'package:madlineindia/logic/repos/mentor_repo.dart';
import 'package:madlineindia/ui/cosnts/apptheme.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:madlineindia/ui/cosnts/default_values.dart';
import 'package:madlineindia/ui/cosnts/responsive_design.dart';
import 'package:provider/provider.dart';
import '../../widgets/alert_banner.dart';

class MentorProfile extends StatefulWidget {
  const MentorProfile({Key? key}) : super(key: key);

  @override
  State<MentorProfile> createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  bool istabinit = false;

  actionButton({required VoidCallback onTap, required String title}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: widthOf(context, 100) > 600
          ? TextButton(child: Text(title), onPressed: onTap)
          : ListTile(
              onTap: () {
                navigation.pop();
                onTap();
              },
              title: Text(
                title,
                style: TextStyle(
                    color: AppThemeData.lightThemeData.colorScheme.primary),
              )));
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  List<Widget> get listActions => [
        actionButton(
          title: 'Home',
          onTap: navigation.pop,
        ),
        actionButton(
          title: 'Courses',
          onTap: navigation.pop,
        ),
        actionButton(
          title: 'Mentors',
          onTap: () {},
        ),
        actionButton(
          title: 'Placements',
          onTap: navigation.pop,
        ),
        actionButton(
          title: 'Contect',
          onTap: navigation.pop,
        )
      ];
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<MentorRepo>();
    final textTheme = Theme.of(context).textTheme;
    if (repo.isEmpty) {
      return scaffoldcIndicator();
    } else {
      if (!repo.isEmpty && !istabinit) {
        tabController = TabController(
            length: repo.list.length,
            animationDuration: defaultDuration,
            vsync: this);
        istabinit = true;
      }
      return Scaffold(
        drawer: widthOf(context, 100) < 600
            ? Drawer(
                backgroundColor: Colors.black,
                width: widthOf(context, 50),
                child: ListView(
                    children: <Widget>[Image.asset('assets/logo/main.png')] +
                        listActions))
            : null,
        appBar: AppBar(
          automaticallyImplyLeading: widthOf(context, 100) < 600,
          centerTitle: widthOf(context, 100) < 600,
          title: Image.asset('assets/logo/main.png'),
          actions: widthOf(context, 100) < 600 ? null : listActions,
          bottom: TabBar(
              controller: tabController,
              tabs: repo.list.map((e) {
                return ListTile(
                  leading: Container(
                      decoration:
                          BoxDecoration(borderRadius: defaultBorderRadius),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(e.pic)),
                  title: Text(
                    e.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList()),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: ResponsiveLayout(
                small: TabBarView(
                    controller: tabController,
                    children: repo.list
                        .map((e) => ListView(
                                children: _smallScreen(
                              e,
                            )))
                        .toList()),
                large: TabBarView(
                    controller: tabController,
                    children: repo.list
                        .map((e) => Row(children: _largeScreen(e)))
                        .toList()),
              ),
            ),
            if (!context.watch<AnouncementRepo>().isEmpty)
              const Positioned(
                  bottom: 0, right: 0, left: 0, child: AlertBanner()),
          ],
        ),
      );
    }
  }

  _smallScreen(e) => [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                e.pic,
                width: double.maxFinite,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 10),
              Text(
                e.name,
                style: style.headline4,
              ),
              Text(e.label)
            ],
          ),
        ),
        Markdown(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          data: e.about.replaceAll('\\n', '\n'),
          selectable: true,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            h3: Theme.of(context).textTheme.headline5!,
            tableBody: const TextStyle(fontSize: 18),
            p: const TextStyle(fontSize: 18),
            listBullet: const TextStyle(fontSize: 18),
          ),
        )
      ];

  _largeScreen(e) => [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Image.network(
                    e.pic,
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    e.name,
                    style: style.headline3,
                  ),
                  Text(e.label)
                ],
              ),
            )),
        Expanded(
            flex: 2,
            child: Markdown(
              padding: const EdgeInsets.fromLTRB(16, 32, 32, 32),
              data: e.about.replaceAll('\\n', '\n'),
              selectable: true,
              styleSheet:
                  MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                h3: Theme.of(context).textTheme.headline4!,
                tableBody: const TextStyle(fontSize: 18),
                p: const TextStyle(fontSize: 18),
                listBullet: const TextStyle(fontSize: 18),
              ),
            ))
      ];
}
