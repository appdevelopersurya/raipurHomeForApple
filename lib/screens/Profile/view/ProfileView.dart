import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/data/modal/deleteAccountDataModel.dart';
import 'package:fmraipuromes/data/modal/webViewModal.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/getImageFromUser.dart';
import 'package:fmraipuromes/screens/MainHome/viewModal/mainHomeViewModal.dart';
import 'package:fmraipuromes/screens/Profile/viewModel/profileViewModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/ProfileCard.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:fmraipuromes/utils/futureLoaderNew.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/color.dart';
import '../../../data/modal/PopularAllListArgModal.dart';
import '../../Drawer/view/mainDrawerNew.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _launchStore(BuildContext context) async {
    var storeURL = Platform.isAndroid
        // ? "whatsapp://send?phone=$whatsappNumber&text=${Uri.encodeComponent(message)}"
        ? "https://play.google.com/store/apps/details?id=com.raipurHomes"
        : "https://www.apple.com/in/app-store/";
    // : "whatsapp://send?phone=$whatsappNumber&text=${Uri.encodeFull(message)}";

    if (!await launchUrl(Uri.parse(storeURL))) {
      throw Exception('Could not launch $storeURL');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid URL"),
        ),
      );
    }
  }

  _firstLoad() async {
    final profileViewController =
        Provider.of<ProfileViewModel>(context, listen: false);
    if (mounted) {
      profileViewController.getUserDetail(false);
      // profileViewController.setIsLoading(false);
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainHomeController = Provider.of<MainHomeViewViewModal>(context);
    final profileViewController = Provider.of<ProfileViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        mainHomeController.changeIndexAccordingScreen(0);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MainDrawerNew(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFffffff),
                  Color(0xFFf3ef66),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // backgroundColor: secondaryColor,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(13.0),
            child: InkWell(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Icon(
                Icons.menu,
                color: textColor2,
              ),
            ),
          ),
          title: Text(
            "Profile",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: textColor2),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Consumer<ProfileViewModel>(
              builder: (context, value, child) {
                return value.isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade50,
                        child: Column(
                          children: [
                            const Gap(20),
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.black,
                            ),
                            Container(
                              height: 10,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.black),
                            ),
                            const Gap(5.0),
                            Container(
                              height: 10,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.black),
                            ),
                            const Gap(20),
                          ],
                        ))
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FadeInDown(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) {
                                      return const Icon(Icons.image);
                                    },
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                    imageUrl:
                                        "${AppUrl.baseUrl}${value.getUserDetails.data?.userImage ?? "https://i.postimg.cc/qv7SgJsy/cropped-Untitled-design-1-1.png"}",
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                          "assets/icons/contact.png");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: FadeInDown(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "Hello! ${value.getUserDetails.data?.userName ?? "User"}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(
                                      "+91${value.getUserDetails.data?.userNumber ?? "9999999999"}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall)
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.profileEdit)
                      .whenComplete(
                    () {
                      context.read<GetImageFromUser>().removeImage();
                    },
                  );
                },
                child: FadeInLeft(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withOpacity(0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/edit.svg",
                            height: 20,
                            width: 20,
                            color: Colors.white,
                          ),
                          const Gap(5),
                          Text(
                            "Edit Profile",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: buttonTextColor, fontSize: 13.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FadeInUp(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(10),
                      ProfileCard(
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.support),
                          title: "Enquiry",
                          leading: SvgPicture.asset(
                            "assets/svg/enquiry.svg",
                            height: 24,
                            width: 24,
                            color: secondaryColor,
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.popularLocations,
                              arguments: PopularAllListArgsModal(
                                pageTitle: "My Property",
                                pageType: "myProperty",
                              )),
                          title: "My Property",
                          leading: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SvgPicture.asset(
                              "assets/svg/property.svg",
                              height: 22,
                              width: 22,
                              color: secondaryColor,
                            ),
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () {
                            Share.share(
                                "🏡 Discover Your Dream Home with Raipur Homes! 🏡"
                                "\nLooking for a new place to call home? Explore a wide range of properties and houses right at your fingertips with Raipur Homes!"
                                "\n\n✨ Key Features:"
                                "\n🔍 Search Effortlessly: Find properties that match your criteria with our easy-to-use search filters."
                                "\n📸 High-Quality Photos: Browse through high-resolution images to get a real feel of your potential new home."
                                "\n🗺️ Interactive Maps: Explore neighborhoods and see what's around your future home."
                                "\n💬 Instant Communication: Connect with property owners through the app."
                                "\n💼 Exclusive Listings: Get access to listings you won't find anywhere else."
                                "\n\nReady to find your dream home? Download Raipur Homes now and start your journey to a new home!"
                                "\n🔗https://play.google.com/store/apps/details?id=com.raipurHomes");
                          },
                          title: "Share App",
                          leading: SvgPicture.asset(
                            "assets/svg/share.svg",
                            height: 22,
                            width: 22,
                            color: secondaryColor,
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.webView,
                                arguments: WebViewModal(
                                    url:
                                        "https://www.raipurhomes.com/terms-conditions-mobile",
                                    title: "Terms & Conditions"));
                          },
                          title: "Terms and Conditions",
                          leading: Image.asset(
                            "assets/icons/terms.png",
                            height: 24,
                            width: 24,
                            color: secondaryColor,
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.webView,
                                arguments: WebViewModal(
                                    url:
                                        "https://www.raipurhomes.com/privacy-policy-mobile",
                                    title: "Privacy Policy"));
                          },
                          title: "Privacy Policy",
                          leading: SvgPicture.asset(
                            "assets/svg/policy.svg",
                            height: 24,
                            width: 24,
                            color: secondaryColor,
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.webView,
                                arguments: WebViewModal(
                                    url:
                                        "https://www.raipurhomes.com/about-us-mobile",
                                    title: "About Us"));
                          },
                          title: "About Us",
                          leading: SvgPicture.asset(
                            "assets/svg/about.svg",
                            height: 24,
                            width: 24,
                            color: secondaryColor,
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () {
                            _launchStore(context);
                          },
                          title: "Rate Us",
                          leading: Icon(
                            Icons.star,
                            size: 24,
                            color: secondaryColor,
                          )),
                      const Divider(),
                      ProfileCard(
                          onTap: () {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInDown(
                                            child: Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor:
                                                      secondaryColor,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        const AssetImage(
                                                      "assets/icons/contact.png",
                                                    ),
                                                    backgroundColor:
                                                        primaryColor,
                                                    radius: 48,
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: CircleAvatar(
                                                      radius: 18,
                                                      child: Icon(
                                                        Icons.warning_amber,
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
                                            'Do your account?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        FadeInLeft(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'You will loss your all data  by deleting your account. This section can not be undone.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: subTitleColor),
                                          ),
                                        ),
                                        const Gap(20),
                                        FadeInDown(
                                          child: CustomButton(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              title:
                                                  "No! I've changed my mind"),
                                        ),
                                        const Gap(10),
                                        FadeInUp(
                                          child: TextButton(
                                            onPressed: () async {
                                              customFutureLoader(
                                                  context: context,
                                                  future: () async {
                                                    return profileViewController
                                                        .deleteMyAccount();
                                                  }).then((value) {
                                                DeleteAccountDataModel
                                                    deleteAcModel =
                                                    value.asValue?.value ??
                                                        DeleteAccountDataModel();
                                                if (deleteAcModel.success ==
                                                    true) {
                                                  Utils.snackBar(
                                                      deleteAcModel.message
                                                          .toString(),
                                                      context,
                                                      successColor);
                                                  GetStorageHelper
                                                      .clearDataIfLogged();
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                    context,
                                                    AppRoutes.loginNumber,
                                                    (route) => false,
                                                  );
                                                } else {
                                                  Utils.snackBar(
                                                      "Account deleting failed",
                                                      context,
                                                      errorColor);
                                                  Navigator.pop(context);
                                                }
                                              });
                                            },
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Delete my account',
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
                          },
                          title: "Delete Account",
                          leading: Icon(
                            Icons.delete,
                            size: 24,
                            color: secondaryColor,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}
