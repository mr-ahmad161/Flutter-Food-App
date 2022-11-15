import 'package:flutter/material.dart';
import 'package:foodapp/admin/admin_screen.dart';
import 'package:foodapp/core/app_colors.dart';
import 'package:foodapp/login/loginpage.dart';
import 'package:foodapp/user_view_model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
// import 'package:responsive_framework/responsive_wrapper.dart';
// import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  // ignore: avoid_print
  print(Hive.box('userBox').get('email'));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: const MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // builder: (context, child) => ResponsiveWrapper.builder(
        //     BouncingScrollWrapper.builder(context, child!),
        //     maxWidth: 1500,
        //     minWidth: 450,
        //     defaultScale: true,
        //     breakpoints: [
        //       const ResponsiveBreakpoint.resize(450, name: MOBILE),
        //       const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //       const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        //       const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        //       const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        //     ],
        //     background: Container(color: const Color(0xFFF5F5F5))),
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          canvasColor: AppColors.canvasColor,
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Hive.box('userBox').get('email') == null
            ? const LoginPage()
            : AdminPage());
  }
}
