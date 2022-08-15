import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:madlineindia/firebase_options.dart';
import 'package:madlineindia/logic/repos/anouncement_repo.dart';
import 'package:madlineindia/logic/repos/coursesrepo.dart';
import 'package:madlineindia/logic/repos/mentor_repo.dart';
import 'package:madlineindia/ui/cosnts/apptheme.dart';
import 'package:madlineindia/ui/cosnts/config.dart';
import 'package:provider/provider.dart';
import 'logic/repos/details_repo.dart';
import 'ui/pages/homepage/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CoursesRepo>.value(
              value: CoursesRepo('courses')),
          ChangeNotifierProvider<DetailsRepo>.value(
              value: DetailsRepo('details', 'czVuSlOXsJzRm3fvlmg6')),
          ChangeNotifierProvider<AnouncementRepo>.value(
              value: AnouncementRepo('announcement', 'ny2g2Fv9ZNvlgrIhzPkD')),
          ChangeNotifierProvider<MentorRepo>(
              create: (_) => MentorRepo('mentors')),
        ],
        builder: (context, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              navigatorKey: Config.navigatorKey,
              theme: AppThemeData.lightThemeData,
              // darkTheme: AppThemeData.darkThemeData,
              home: const HomePage());
        });
  }
}
