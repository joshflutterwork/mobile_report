import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keluarga_bintoro/controllers/controllers.dart';
import 'package:keluarga_bintoro/shared/shareds.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'providers/providers.dart';
import 'ui/pages/pages.dart';

PackageInfo? packageInfo;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize(debug: true);
  HttpOverrides.global = MyHttpOverrides();
  packageInfo = await PackageInfo.fromPlatform();
  await Firebase.initializeApp();
  await GetStorage.init();
  await OneSignal.shared.setAppId(appId);
  // await OneSignal.shared
  //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
  // var status = await OneSignal.shared.getPermissionSubscriptionState();
  // var playerId = status.subscriptionStatus.userId;
  var deviceState = await OneSignal.shared.getDeviceState();
  //if (deviceState == null || deviceState.userId == null) return;
  var playerId = deviceState!.userId;
  final box = GetStorage();
  box.write('playerId', playerId);
  // optional: set false to disable printing logs to console
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => LeaveProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white, // status bar color
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(mySystemUIOverlaySyle);
    return GetMaterialApp(
      color: mainColor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        primarySwatch: Colors.red,
        fontFamily: "Quicksand",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // builder: (context, child) {
      //   return ScrollConfiguration(
      //     behavior: MyBehavior(),
      //     child: child,
      //   );
      // },
      builder: BotToastInit(),
      title: 'Keluarga Bintoro',
      home: Splash(),
      initialBinding: BindingsBuilder(() => {
            Get.lazyPut<AuthController>(() => AuthController()),
            Get.lazyPut<UserController>(() => UserController()),
          }),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
