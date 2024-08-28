import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/repository/counter_provider.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:fmraipuromes/repository/getImageFromUser.dart';
import 'package:fmraipuromes/screens/Home/viewModal/homeViewController.dart';
import 'package:fmraipuromes/screens/MainHome/viewModal/mainHomeViewModal.dart';
import 'package:fmraipuromes/screens/Profile/viewModel/profileViewModel.dart';
import 'package:fmraipuromes/screens/SubPages/Blog/blogViewDetails/viewModel/blogDetailsViewMocel.dart';
import 'package:fmraipuromes/screens/SubPages/Explore/viewModel/exploreViewModel.dart';
import 'package:fmraipuromes/screens/SubPages/PopularLocationPropertyList/viewModal/popularLocationPropertyListViewModal.dart';
import 'package:fmraipuromes/screens/SubPages/Support/supportViewModel.dart';
import 'package:fmraipuromes/screens/auth/VerifyOTP/viewModal/OTPViewController.dart';
import 'package:fmraipuromes/screens/auth/login/viewModel/loginViewController.dart';
import 'package:fmraipuromes/screens/subpages/PropertyDetailsPage/viewModal/propertyDetailsViewModal.dart';
import 'package:fmraipuromes/services/httpClienOverride/httpClientOverride.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app/routes/routes.dart';
import 'app/routes/routes_call.dart';
import 'app/theme/theme.dart';
import 'firebase_options.dart';
import 'helper/GetStorageHelper.dart';
import 'repository/bookMarkController.dart';
import 'screens/LatestProperty/viewModel/latestPropertyController.dart';
import 'screens/Notification/viewModel/notificationViewModel.dart';
import 'screens/SubPages/Blog/viewModel/blogViewModel.dart';
import 'screens/SubPages/MainSearch/viewModel/mainSearchViewModel.dart';
import 'screens/SubPages/PostProperty/viewModel/postPropertyViewModel.dart';
import 'services/notifications/pushNotifications.dart';

@pragma('vm:entry-point')
Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  PushNotifications.init();
  PushNotifications.firebaseInitial();
  PushNotifications.isTokenRefreshed();

  runApp(const MyApp());
  // runApp(DevicePreview(
  //     enabled: !kReleaseMode, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => MainHomeViewViewModal()),
          ChangeNotifierProvider(create: (_) => OTPViewController()),
          ChangeNotifierProvider(create: (_) => HomeVIewController()),
          ChangeNotifierProvider(create: (_) => GetImageFromUser()),
          ChangeNotifierProvider(create: (_) => LoginViewController()),
          ChangeNotifierProvider(create: (_) => ProfileViewModel()),
          ChangeNotifierProvider(create: (_) => MainSearchViewModel()),
          ChangeNotifierProvider(create: (_) => PostPropertyViewModel()),
          ChangeNotifierProvider(create: (_) => LatestPropertyController()),
          ChangeNotifierProvider(create: (_) => GetFilterTools()),
          ChangeNotifierProvider(create: (_) => BookMarkController()),
          ChangeNotifierProvider(create: (_) => SupportViewModel()),
          ChangeNotifierProvider(create: (_) => ExploreViewModel()),
          ChangeNotifierProvider(create: (_) => NotificationViewModel()),
          ChangeNotifierProvider(create: (_) => BlogViewModel()),
          ChangeNotifierProvider(create: (_) => BlogDetailsViewModel()),
          ChangeNotifierProvider(
              create: (_) => PopularLocationPropertyListViewModal()),
          ChangeNotifierProvider(
              create: (_) => PropertyDetailsViewController()),
        ],
        child: MaterialApp(
          builder: (context, child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                  textScaler: size.width > 640
                      ? const TextScaler.linear(0.5)
                      : const TextScaler.linear(1.0)),
              child: child!,
            );
          },
          title: 'Raipur Homes',
          theme: MyTheme.lightTheme(context),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: Routes.generateRoutes,
        ));
  }
}
