import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:gap/gap.dart';
import '../app/routes/routes.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onTapLogo;
  final VoidCallback? onTapMenu;

  const HomeAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    this.onTapLogo,
    this.onTapMenu,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
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
      toolbarHeight: 60,
      leadingWidth: MediaQuery.of(context).size.width * 0.7,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FadeInDown(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: widget.onTapMenu,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: borderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.menu,
                      size: 27,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    "assets/png/rprNewLogo2.png"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // FadeInDown(
        //   child: InkWell(
        //     onTap: () {
        //       // Navigator.pushNamed(context, AppRoutes.notifications);
        //     },
        //     child: Container(
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(width: 1, color: borderColor)),
        //       child: Padding(
        //         padding: const EdgeInsets.all(5.0),
        //         child: SvgPicture.asset(
        //           "assets/svg/profile.svg",
        //           height: 24,
        //           width: 24,
        //           color: iconColor,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // const Gap(5.0),
        FadeInDown(
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: borderColor)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/svg/notifications.svg",
                  height: 24,
                  width: 27,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
        const Gap(5.0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
