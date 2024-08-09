import 'package:flutter/material.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/data/modal/PopularAllListArgModal.dart';
import 'package:fmraipuromes/data/modal/SentOtpResponseModel.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/data/modal/webViewModal.dart';
import 'package:fmraipuromes/screens/Fovorite/view/favoriteView.dart';
import 'package:fmraipuromes/screens/Home/view/homeView.dart';
import 'package:fmraipuromes/screens/MainHome/view/mainHomeView.dart';
import 'package:fmraipuromes/screens/OnBoardScreen/view/onBoardScreen.dart';
import 'package:fmraipuromes/screens/Profile/AreaConverter/view/areaCalculator.dart';
import 'package:fmraipuromes/screens/Profile/PersonalDetails/view/profileEditView.dart';
import 'package:fmraipuromes/screens/SubPages/Explore/view/exploreView.dart';
import 'package:fmraipuromes/screens/SubPages/FilterModule/view/filterBottomSheetPage.dart';
import 'package:fmraipuromes/screens/SubPages/MainSearch/view/mainSearchView.dart';
import 'package:fmraipuromes/screens/SubPages/PostProperty/view/postProperty.dart';
import 'package:fmraipuromes/screens/SubPages/Support/supportView.dart';
import 'package:fmraipuromes/screens/SubPages/WebView/webViewForAll.dart';
import 'package:fmraipuromes/screens/auth/VerifyOTP/view/verifyOTPView.dart';
import 'package:fmraipuromes/screens/auth/login/view/loginView.dart';
import 'package:fmraipuromes/screens/auth/newProfile/view/RegistrationView.dart';
import 'package:fmraipuromes/screens/subpages/PopularLocationPropertyList/view/popularLocationPropertyList.dart';
import 'package:fmraipuromes/screens/subpages/popularAllList/view/popularListAll.dart';
import 'package:go_router/go_router.dart';
import '../../screens/Splash/view/splash_screen.dart';
import '../../screens/SubPages/PropertyDetailsPage/view/proprtyDetailsPage.dart';

class GoRouteCall {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const Splash_Screen(),
      ),
      GoRoute(
        path: AppRoutes.onBoarding,
        builder: (BuildContext context, GoRouterState state) =>
            const OnBoardScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeMain,
        builder: (BuildContext context, GoRouterState state) =>
            const MainHomeView(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeView(),
      ),
      GoRoute(
        path: AppRoutes.loginNumber,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (BuildContext context, GoRouterState state) {
          final args = state.extra as SentOtpResponseModel;
          return VerifyOTPView(sentOtpResponseModel: args);
        },
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (BuildContext context, GoRouterState state) =>
            const RegistrationView(),
      ),
      GoRoute(
        path: AppRoutes.popularLocations,
        builder: (BuildContext context, GoRouterState state) {
          final args = state.extra as PopularAllListArgsModal;
          return PopularAllList(allListArgsModal: args);
        },
      ),
      GoRoute(
        path: AppRoutes.propertyDetailView,
        builder: (BuildContext context, GoRouterState state) {
          final args = state.pathParameters['id']!;
          return PropertyDetailsView(propertyID: args);
        },
      ),
      GoRoute(
        path: AppRoutes.favoriteView,
        builder: (BuildContext context, GoRouterState state) =>
            const FavoriteView(),
      ),
      GoRoute(
        path: AppRoutes.popularLocationPropertyList,
        builder: (BuildContext context, GoRouterState state) {
          final args = state.extra as PassFilterModel;
          return PopularLocationPropertyList(passFilterModel: args);
        },
      ),
      GoRoute(
        path: AppRoutes.support,
        builder: (BuildContext context, GoRouterState state) =>
            const SupportView(),
      ),
      GoRoute(
        path: AppRoutes.profileEdit,
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileEditView(),
      ),
      GoRoute(
        path: AppRoutes.mainFilter,
        builder: (BuildContext context, GoRouterState state) {
          final args = state.extra as PassFilterModel;
          return MainFilter(passFilterModel: args);
        },
      ),
      GoRoute(
        path: AppRoutes.areaCalc,
        builder: (BuildContext context, GoRouterState state) =>
            const AreaCalculator(),
      ),
      GoRoute(
        path: AppRoutes.postProperty,
        builder: (BuildContext context, GoRouterState state) =>
            const PostProperty(),
      ),
      GoRoute(
        path: AppRoutes.filterNew,
        builder: (BuildContext context, GoRouterState state) =>
            const FilterPage(),
      ),
      GoRoute(
        path: AppRoutes.webView,
        builder: (BuildContext context, GoRouterState state) {
          final args = state.extra as WebViewModal;
          return WebViewForAll(webViewModal: args);
        },
      ),
      GoRoute(
        path: AppRoutes.exploreView,
        builder: (BuildContext context, GoRouterState state) =>
            const ExploreView(),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) => Scaffold(
      body: Center(
        child: Text(
          "No route defined",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    ),
  );
}
