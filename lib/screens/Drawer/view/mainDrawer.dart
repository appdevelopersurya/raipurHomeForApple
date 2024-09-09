import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:fmraipuromes/screens/MainHome/viewModal/mainHomeViewModal.dart';
import 'package:fmraipuromes/screens/Profile/viewModel/profileViewModel.dart';
import 'package:fmraipuromes/screens/SubPages/Support/supportViewModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../helper/GetStorageHelper.dart';
import '../../../repository/contactFeatures.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String? name;
  String? number;

  _firstLoad() async {
    final profileViewController =
        Provider.of<ProfileViewModel>(context, listen: false);
    final filterToolViewModel =
        Provider.of<GetFilterTools>(context, listen: false);
    final supportViewController =
        Provider.of<SupportViewModel>(context, listen: false);
    if (mounted) {
      filterToolViewModel.fetchFilterTools();
      supportViewController.getContactDetails();
      box.read("access_token_raipurHomes") == ""
          ? ""
          : profileViewController.getUserDetail(false);
      name = profileViewController.getUserDetails.data?.userName ??
          "Update Profile";
      number = profileViewController.getUserDetails.data?.userNumber ?? "";
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewController = Provider.of<ProfileViewModel>(context);
    final filterToolViewModel = Provider.of<GetFilterTools>(context);
    final supportViewController = Provider.of<SupportViewModel>(context);
    return Drawer(
        elevation: 0,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
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
                          context
                              .read<MainHomeViewViewModal>()
                              .changeIndexAccordingScreen(3);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: secondaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 31,
                                backgroundColor: secondaryColor,
                                child: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  radius: 30,
                                  child: profileViewController
                                              .getUserDetails.data?.userImage !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: AppUrl.baseUrl +
                                              profileViewController
                                                  .getUserDetails
                                                  .data!
                                                  .userImage!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            backgroundImage: imageProvider,
                                            radius: 30,
                                          ),
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/icons/contact.png"),
                                            radius: 30,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/icons/contact.png"),
                                          radius: 30,
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    box.read("access_token_raipurHomes") == ""
                                        ? Text(
                                            "Sign In",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          )
                                        : Text(
                                            name ?? "Update Profile",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                    box.read("access_token_raipurHomes") == ""
                                        ? Text(
                                            maxLines: 2,
                                            "Sign in to sync your \ndetails",
                                            overflow: TextOverflow.visible,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          )
                                        : Text(number ?? "+911234567890",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 13.0))
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  if (box.read("access_token_raipurHomes") ==
                                      "") {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                                Icons.close,
                                                                color:
                                                                    errorColor,
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                                FadeInLeft(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    'Log in to enjoy all the features and a customized experience.',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color:
                                                                subTitleColor),
                                                  ),
                                                ),
                                                const Gap(20),
                                                FadeInDown(
                                                  child: CustomButton(
                                                      onTap: () => Navigator
                                                              .pushNamedAndRemoveUntil(
                                                            context,
                                                            AppRoutes
                                                                .loginNumber,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      'Not Now',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color:
                                                                  errorColor),
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
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.profileEdit);
                                  }
                                },
                                child: SvgPicture.asset(
                                  "assets/svg/edit.svg",
                                  height: 24,
                                  width: 24,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  // Home
                  InkWell(
                    onTap: () => context
                        .read<MainHomeViewViewModal>()
                        .changeIndexAccordingScreen(0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Text(
                        "Home",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  // Property Type Wise
                  ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    expansionAnimationStyle:
                        AnimationStyle(curve: Curves.easeInOut),
                    title: Text(
                      "Property Type",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 0.0),
                    children: filterToolViewModel.filterToolsDataModel.type
                            ?.map((pType) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.mainFilter,
                                arguments: PassFilterModel(
                                    id: pType.id,
                                    logLate: "onlySubType",
                                    title: "Main Filter"),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  35.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.left,
                                    pType.name.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList() ??
                        [],
                  ),
                  // Property Sub Type Wise
                  ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    expansionAnimationStyle:
                        AnimationStyle(curve: Curves.easeInOut),
                    title: Text(
                      "Property Sub Type",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 0.0),
                    children: filterToolViewModel
                            .filterToolsDataModel.propertyType
                            ?.map((pType) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.mainFilter,
                                arguments: PassFilterModel(
                                    id: pType.id,
                                    logLate: "onlyProperty",
                                    title: "Main Filter"),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  35.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.left,
                                    pType.name.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList() ??
                        [],
                  ),
                  // Project Wise
                  // ExpansionTile(
                  //   childrenPadding: EdgeInsets.zero,
                  //   expansionAnimationStyle:
                  //       AnimationStyle(curve: Curves.easeInOut),
                  //   title: Text(
                  //     "Project Wise",
                  //     style: Theme.of(context).textTheme.labelSmall,
                  //   ),
                  //   tilePadding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 0.0),
                  //   children: filterToolViewModel.filterToolsDataModel.builders
                  //           ?.map((projectWise) {
                  //         return InkWell(
                  //           onTap: () {
                  //             Navigator.pushNamed(
                  //               context,
                  //               AppRoutes.mainFilter,
                  //               arguments: PassFilterModel(
                  //                   id: projectWise.id,
                  //                   logLate: "onlyBuilder",
                  //                   title: "Main Filter"),
                  //             );
                  //           },
                  //           child: Padding(
                  //             padding: const EdgeInsets.fromLTRB(
                  //                 35.0, 5.0, 5.0, 5.0),
                  //             child: Row(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: <Widget>[
                  //                 Text(
                  //                   projectWise.name.toString(),
                  //                   style:
                  //                       Theme.of(context).textTheme.labelSmall,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }).toList() ??
                  //       [],
                  // ),
                  //Projects
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.ourProjectsList),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Text(
                        "Projects",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  //Explore
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context, AppRoutes.exploreView,
                      // arguments: WebViewModal(
                      //     url: "https://raipurhomes.com/explore-on-map",
                      //     title: "Explore")
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Text(
                        "Explore",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  // Blogs
                  const Gap(10.0),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.blogView),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Text(
                        "Blogs",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  const Gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            ContactFeatures().launchInstagram(
                                context,
                                supportViewController
                                    .contactUsDataModel.data!.instagramID
                                    .toString()
                                    .split("/")[3]);
                          },
                          child: SvgPicture.asset(
                            "assets/svg/instaSvg.svg",
                            // color: Colors.white,
                          )),
                      const Gap(10.0),
                      InkWell(
                        onTap: () {
                          ContactFeatures().launchFacebook(
                              context,
                              supportViewController
                                  .contactUsDataModel.data!.fbID
                                  .toString()
                                  .split("/")[4]
                                  .replaceAll("-", ""));
                        },
                        child: SvgPicture.asset(
                          "assets/svg/fbSvg.svg",
                          // color: Colors.white,
                        ),
                      ),
                      const Gap(10.0),
                      InkWell(
                        onTap: () {
                          ContactFeatures().launchYoutube(
                              context,
                              supportViewController
                                  .contactUsDataModel.data!.ytChannelID
                                  .toString()
                                  .split("/")[3]);
                        },
                        child: SvgPicture.asset(
                          "assets/svg/youtubeSvg.svg",
                          // color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            box.read("access_token_raipurHomes") == ""
                ? const Offstage()
                : InkWell(
                    onTap: () {
                      box.write('is_logged_raipurHome', false);
                      box.write('access_token_raipurHomes', "");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.loginNumber,
                        (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Log Out",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: textColor2),
                          ),
                          const Gap(10),
                          const Icon(
                            Icons.logout,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ));
  }
}
