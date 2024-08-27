import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/getImageFromUser.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../app/routes/routes.dart';
import '../screens/SubPages/TestingDropDown.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onTapLogo;

  const HomeAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    this.onTapLogo,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(105);
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 105,
      leadingWidth: 120,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FadeInDown(
          child: InkWell(
            onTap: widget.onTapLogo,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    height: 95,
                    width: 100,
                    fit: BoxFit.cover,
                    "assets/png/rprNewLogo.png",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        FadeInDown(
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
                        constraints:
                            BoxConstraints.loose(const Size.fromHeight(400)),
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
                                        backgroundImage: const AssetImage(
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
                                    .copyWith(fontWeight: FontWeight.w600),
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
                                  onTap: () =>
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.loginNumber,
                                        (route) => false,
                                      ),
                                  title: "Yes, Login"),
                            ),
                            const Gap(10),
                            FadeInUp(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
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
                Navigator.pushNamed(context, AppRoutes.postProperty)
                    .whenComplete(
                  () {
                    final imageController = context.read<GetImageFromUser>();
                    imageController.removeImage();
                  },
                );
              }
            },
            // onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const TestingDropDown(),
            //     )),
            child: const CircleAvatar(
                backgroundColor: Colors.white30,
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                )),
          ),
        ),
        const Gap(5.0),
        FadeInDown(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.support),
            // onTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const TestingDropDown(),
            //     )),
            child: CircleAvatar(
              backgroundColor: Colors.white30,
              child: Image.asset(
                "assets/icons/support.png",
                color: Colors.grey,
                height: 22,
                width: 22,
              ),
            ),
          ),
        ),
        const Gap(5.0),
        FadeInDown(
          child: InkWell(
            onTap: () => widget._scaffoldKey.currentState!.openEndDrawer(),
            child: const CircleAvatar(
              backgroundColor: Colors.white30,
              child: Icon(
                Icons.menu,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const Gap(5.0),
      ],
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
      // backgroundColor: textColor5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(105);
}
