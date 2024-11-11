import 'package:flutter/material.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/data/modal/PopularAllListArgModal.dart';
import 'package:fmraipuromes/data/modal/SentOtpResponseModel.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/data/modal/webViewModal.dart';
import 'package:fmraipuromes/screens/Fovorite/view/favoriteView.dart';
import 'package:fmraipuromes/screens/Home/view/homeView.dart';
import 'package:fmraipuromes/screens/MainHome/view/mainHomeView.dart';
import 'package:fmraipuromes/screens/Notification/view/notificationView.dart';
import 'package:fmraipuromes/screens/OnBoardScreen/view/onBoardScreen.dart';
import 'package:fmraipuromes/screens/Profile/AreaConverter/view/areaCalculator.dart';
import 'package:fmraipuromes/screens/Profile/PersonalDetails/view/profileEditView.dart';
import 'package:fmraipuromes/screens/SubPages/Blog/blogViewDetails/view/blogViewDetails.dart';
import 'package:fmraipuromes/screens/SubPages/Blog/view/blogView.dart';
import 'package:fmraipuromes/screens/SubPages/Explore/view/exploreView.dart';
import 'package:fmraipuromes/screens/SubPages/FilterModule/view/filterBottomSheetPage.dart';
import 'package:fmraipuromes/screens/SubPages/MainSearch/view/mainSearchView.dart';
import 'package:fmraipuromes/screens/SubPages/OurProjects/view/OurProjects.dart';
import 'package:fmraipuromes/screens/SubPages/OurProjects/view/OurProjectsListView.dart';
import 'package:fmraipuromes/screens/SubPages/PostProperty/view/postProperty.dart';
import 'package:fmraipuromes/screens/SubPages/Support/supportView.dart';
import 'package:fmraipuromes/screens/SubPages/WebView/webViewForAll.dart';
import 'package:fmraipuromes/screens/auth/VerifyOTP/view/verifyOTPView.dart';
import 'package:fmraipuromes/screens/auth/login/view/loginView.dart';
import 'package:fmraipuromes/screens/auth/newProfile/view/RegistrationView.dart';
import 'package:fmraipuromes/screens/subpages/PopularLocationPropertyList/view/popularLocationPropertyList.dart';
import 'package:fmraipuromes/screens/subpages/popularAllList/view/popularListAll.dart';

import '../../screens/splash/view/splash_screen.dart';
import '../../screens/subpages/PropertyDetailsPage/view/proprtyDetailsPage.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Splash_Screen());
      case AppRoutes.onBoarding:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardScreen());
      case AppRoutes.homeMain:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainHomeView());
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case AppRoutes.loginNumber:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case AppRoutes.otpVerification:
        return MaterialPageRoute(
            builder: (BuildContext context) => VerifyOTPView(
                  sentOtpResponseModel: args as SentOtpResponseModel,
                ));
      case AppRoutes.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegistrationView());
      case AppRoutes.popularLocations:
        return MaterialPageRoute(
            builder: (BuildContext context) => PopularAllList(
                  allListArgsModal: args as PopularAllListArgsModal,
                ));
      case AppRoutes.propertyDetailView:
        return MaterialPageRoute(
            builder: (BuildContext context) => PropertyDetailsView(
                  propertyID: args.toString(),
                ));
      case AppRoutes.favoriteView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FavoriteView());
      case AppRoutes.popularLocationPropertyList:
        return MaterialPageRoute(
            builder: (BuildContext context) => PopularLocationPropertyList(
                passFilterModel: args as PassFilterModel));
      case AppRoutes.support:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SupportView());
      case AppRoutes.profileEdit:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileEditView());
      case AppRoutes.mainFilter:
        return MaterialPageRoute(
            builder: (BuildContext context) => MainFilter(
                  passFilterModel: args as PassFilterModel,
                ));
      case AppRoutes.areaCalc:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AreaCalculator());
      case AppRoutes.postProperty:
        return MaterialPageRoute(
          builder: (context) => const PostProperty(),
        );
      case AppRoutes.filterNew:
        return MaterialPageRoute(
          builder: (context) => const FilterPage(),
        );
      case AppRoutes.webView:
        return MaterialPageRoute(
          builder: (context) =>
              WebViewForAll(webViewModal: args as WebViewModal),
        );
      case AppRoutes.exploreView:
        return MaterialPageRoute(
          builder: (context) => const ExploreView(),
        );
      case AppRoutes.blogView:
        return MaterialPageRoute(
          builder: (context) => const BlogView(),
        );
      case AppRoutes.blogViewDetails:
        return MaterialPageRoute(
          builder: (context) => BlogViewDetails(
            blogId: args.toString(),
          ),
        );
      case AppRoutes.ourProjects:
        return MaterialPageRoute(
          builder: (context) => OurProjects(
            allListArgsModal: args as PassFilterModel,
          ),
        );
      case AppRoutes.ourProjectsList:
        return MaterialPageRoute(
          builder: (context) => const OurProjectsListView(),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (context) => const NotificationView(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
                child: Text(
              "No route defined",
              style: Theme.of(_).textTheme.titleMedium,
            )),
          );
        });
    }
  }
}
