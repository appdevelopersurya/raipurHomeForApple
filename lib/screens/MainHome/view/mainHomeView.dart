import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/screens/Home/view/homeView.dart';
import 'package:fmraipuromes/screens/LatestProperty/view/latestPropertyView.dart';
import 'package:fmraipuromes/screens/Profile/view/ProfileView.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../repository/persmissionHandler.dart';
import '../../Notification/view/notificationView.dart';
import '../viewModal/mainHomeViewModal.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  PageController _pageController = PageController(initialPage: 0);
  final PermissionHandlerService _permissionHandler =
      PermissionHandlerService();
  Future<void> _requestPermissions() async {
    bool allPermissionsGranted =
        await _permissionHandler.requestAllPermissions();
    if (allPermissionsGranted) {
      print("All permissions granted!");
    } else {
      print("Some permissions were not granted.");
    }
  }

  @override
  void initState() {
    _requestPermissions();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> Pages = [
    const HomeView(),
    const LatestPropertyView(),
    const NotificationView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainHomeViewViewModal>(
      builder: (context, mainHomeProvider, child) {
        return Scaffold(
          body: Pages[mainHomeProvider.currentIndex],
          // extendBody: true,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        mainHomeProvider.changeIndexAccordingScreen(0);
                      },
                      icon: Icon(
                        mainHomeProvider.currentIndex == 0
                            ? Icons.home
                            : Icons.home_outlined,
                        size: 30.0,
                        color: mainHomeProvider.currentIndex == 0
                            ? secondaryColor
                            : hintColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        mainHomeProvider.changeIndexAccordingScreen(1);
                      },
                      icon: SvgPicture.asset(
                        mainHomeProvider.currentIndex == 1
                            ? "assets/svg/newFill.svg"
                            : "assets/svg/newOutlined.svg",
                        height: 30.0,
                        width: 30.0,
                        color: mainHomeProvider.currentIndex == 1
                            ? secondaryColor
                            : hintColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (box.read("access_token_raipurHomes") == "") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  constraints: BoxConstraints.loose(
                                      const Size.fromHeight(400)),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FadeInDown(
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundColor: secondaryColor,
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      const AssetImage(
                                                    "assets/icons/contact.png",
                                                  ),
                                                  backgroundColor: primaryColor,
                                                  radius: 48,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: errorColor,
                                                      size: 18,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      FadeInRight(
                                        child: Text(
                                          "You're currently using a guest account. Please log in.",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      FadeInLeft(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'Log in to enjoy all the features and a customized experience.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: subTitleColor),
                                        ),
                                      ),
                                      const Gap(20),
                                      FadeInDown(
                                        child: CustomButton(
                                            onTap: () => Navigator
                                                    .pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRoutes.loginNumber,
                                                  (route) => false,
                                                ),
                                            title: "Yes, Login"),
                                      ),
                                      const Gap(10),
                                      FadeInUp(
                                        child: TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'Not Now',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: errorColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          Navigator.pushNamed(context, AppRoutes.favoriteView);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: secondaryColor),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.favorite_border,
                            size: 27,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        mainHomeProvider.changeIndexAccordingScreen(2);
                      },
                      icon: Icon(
                        mainHomeProvider.currentIndex == 2
                            ? Icons.notifications_active
                            : Icons.notifications_on_outlined,
                        size: 30.0,
                        color: mainHomeProvider.currentIndex == 2
                            ? secondaryColor
                            : hintColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (box.read("access_token_raipurHomes") == "") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  constraints: BoxConstraints.loose(
                                      const Size.fromHeight(400)),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FadeInDown(
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundColor: secondaryColor,
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      const AssetImage(
                                                    "assets/icons/contact.png",
                                                  ),
                                                  backgroundColor: primaryColor,
                                                  radius: 48,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: errorColor,
                                                      size: 18,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      FadeInRight(
                                        child: Text(
                                          "You're currently using a guest account. Please log in.",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      FadeInLeft(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'Log in to enjoy all the features and a customized experience.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: subTitleColor),
                                        ),
                                      ),
                                      const Gap(20),
                                      FadeInDown(
                                        child: CustomButton(
                                            onTap: () => Navigator
                                                    .pushNamedAndRemoveUntil(
                                                  context,
                                                  AppRoutes.loginNumber,
                                                  (route) => false,
                                                ),
                                            title: "Yes, Login"),
                                      ),
                                      const Gap(10),
                                      FadeInUp(
                                        child: TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'Not Now',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: errorColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          mainHomeProvider.changeIndexAccordingScreen(3);
                        }
                      },
                      icon: Icon(
                        mainHomeProvider.currentIndex == 3
                            ? Icons.person
                            : Icons.person_outline,
                        size: 30.0,
                        color: mainHomeProvider.currentIndex == 3
                            ? secondaryColor
                            : hintColor,
                      ),
                    ),
                  ]),
            ),
          ),
          // floatingActionButton: mainHomeProvider.isKeyboardOn
          //     ? null
          //     : FloatingActionButton(
          //         backgroundColor: secondaryColor,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(
          //               10.0), // Adjust the radius as needed
          //         ),
          //         child: const Icon(
          //           Icons.favorite_border,
          //           size: 27,
          //         ),
          //         onPressed: () {
          //           Navigator.pushNamed(context, AppRoutes.favoriteView);
          //         },
          //       ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
