import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/constants/textstyles.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:bookmark/widgets/intro_sliders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(isNewDevice: await isFirstTimeInDevice()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isNewDevice});
  bool isNewDevice;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      darkTheme: darkThemeData(context),
      theme: ThemeConfig.lightTheme,
      themeMode: ThemeMode.system,

      // home: HomeView(),
      home: isNewDevice ? OnboardingScreen() : HomeView(),
      // home: OnboardingScreen(),
    );
  }
}

Future<bool> isFirstTimeInDevice() async {
  return (await SharedPrefs.getBool("newDevice")) ?? true;
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    // accentColor: kPrimaryColor,
    // fontFamily: "WorkSans",
    // fontFamily: "Poppins",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.white70,
    backgroundColor: Colors.black,
    // errorColor: kErrorColor,
    textTheme: const TextTheme(
      headline1: TextStyles.h1Heading,
      // bodyText1: TextStyles.pageHeading,
      // bodyText2: TextStyles.pageSubHeading,
      // subtitle1: TextStyles.h1SubHeading,
      labelMedium: TextStyles.subText,
    ),
    // primaryTextTheme: getTextTheme(),
    // accentTextTheme: getTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
