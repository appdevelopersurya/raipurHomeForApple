import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../app/routes/routes.dart';
import '../data/modal/passFilterModel.dart';
import '../helper/GetStorageHelper.dart';
import '../repository/contactFeatures.dart';
import '../repository/getFilterTools.dart';
import '../screens/Profile/viewModel/profileViewModel.dart';
import '../screens/SubPages/Support/supportViewModel.dart';
import '../services/apis/app_url.dart';
import 'CustomButton.dart';

class DraggableModalBottomSheet extends StatelessWidget {
  final String title;
  final int itemCount;

  // Constructor to accept title and item count as parameters
  const DraggableModalBottomSheet({
    Key? key,
    required this.title,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewController = Provider.of<ProfileViewModel>(context);
    final filterToolViewModel = Provider.of<GetFilterTools>(context);
    final supportViewController = Provider.of<SupportViewModel>(context);
    String? name;
    String? number;
    filterToolViewModel.fetchFilterTools();
    supportViewController.getContactDetails();
    box.read("access_token_raipurHomes") == ""
        ? ""
        : profileViewController.getUserDetail(false);
    name =
        profileViewController.getUserDetails.data?.userName ?? "Update Profile";
    number = profileViewController.getUserDetails.data?.userNumber ?? "";
    Size size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      expand: false,
      // Allow dragging
      initialChildSize: 0.8,
      // Start at 30% of the screen height
      minChildSize: 0.3,
      // Minimum height is also set to 30%
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: size.height * 0.11,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: defaultGradient3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.11,
                      width: size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: defaultGradient3,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(1, 0),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: profileViewController
                                          .getUserDetails.data?.userImage !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: AppUrl.baseUrl +
                                          profileViewController
                                              .getUserDetails.data!.userImage!,
                                      height: 55,
                                      width: 55,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                          height: 55,
                                          width: 55,
                                          fit: BoxFit.fill,
                                          "assets/icons/contact.png"),
                                    ),
                            ),
                            const Gap(10),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       "Hi! Suryakant",
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .labelMedium!
                            //           .copyWith(color: textDarkColor),
                            //     ),
                            //     Text("Welcome! to Raipur Homes",
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .labelSmall!
                            //             .copyWith(color: textColor)),
                            //   ],
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                            .labelMedium!
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
                                                fontWeight: FontWeight.w600))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
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
                          Navigator.of(context)
                              .pushNamed(AppRoutes.profileEdit);
                        }
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg/profileEdit.svg",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Gap(20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: [
                    // Property Type Wise
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: borderColor)),
                      child: ExpansionTile(
                        // leading: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Icon(
                        //     Icons.add,
                        //     size: 18,
                        //     color: Colors.grey.shade800,
                        //   ),
                        // ),
                        childrenPadding: EdgeInsets.zero,
                        expansionAnimationStyle:
                            AnimationStyle(curve: Curves.easeInOut),
                        title: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/pType.svg",
                              height: 16,
                              width: 16,
                              color: iconColor,
                            ),
                            const Gap(10),
                            Text(
                              "Property Type",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
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
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: iconColor,
                                      ),
                                      const Gap(10),
                                      Text(
                                        textAlign: TextAlign.left,
                                        pType.name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                    const Gap(10.0),
                    // Property Sub Type Wise
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: borderColor)),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        expansionAnimationStyle:
                            AnimationStyle(curve: Curves.easeInOut),
                        title: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/pSubType.svg",
                              height: 16,
                              width: 16,
                              color: iconColor,
                            ),
                            const Gap(10),
                            Text(
                              "Property Sub Type",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
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
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: iconColor,
                                      ),
                                      const Gap(10),
                                      Text(
                                        textAlign: TextAlign.left,
                                        pType.name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                    const Gap(10.0),
                    // // Project Wise
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
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   height: 55,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(16),
                    //       border: Border.all(width: 1, color: borderColor)),
                    //   child: InkWell(
                    //     onTap: () => Navigator.pushNamed(
                    //       context,
                    //       AppRoutes.ourProjectsList,
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 16.0, vertical: 10.0),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             "Projects",
                    //             style: Theme.of(context).textTheme.labelSmall,
                    //           ),
                    //           const Spacer(),
                    //           Icon(
                    //             Icons.arrow_forward_ios,
                    //             size: 15,
                    //             color: Colors.grey.shade700,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const Gap(10.0),
                    //Explore
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: borderColor)),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context, AppRoutes.exploreView,
                          // arguments: WebViewModal(
                          //     url: "https://raipurhomes.com/explore-on-map",
                          //     title: "Explore")
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/explore.svg",
                                height: 16,
                                width: 16,
                                color: iconColor,
                              ),
                              const Gap(10),
                              Text(
                                "Explore",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Blogs
                    const Gap(10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: borderColor)),
                      child: InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.blogView),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/blog.svg",
                                height: 16,
                                width: 16,
                                color: iconColor,
                              ),
                              const Gap(10),
                              Text(
                                "Blogs",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // const Gap(10.0),
                    // InkWell(
                    //   onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const TestingDropDown(),
                    //     ),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 16.0, vertical: 10.0),
                    //     child: Text(
                    //       "New Test",
                    //       style: Theme.of(context).textTheme.labelSmall,
                    //     ),
                    //   ),
                    // ),
                    const Gap(50.0),
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
                              "assets/svg/insta_outline.svg",
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
                            "assets/svg/fb_outline.svg",
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
                            "assets/svg/yt_outline.svg",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log Out",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: errorColor),
                            ),
                            const Gap(10),
                            Icon(
                              Icons.logout,
                              size: 16,
                              color: errorColor,
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
