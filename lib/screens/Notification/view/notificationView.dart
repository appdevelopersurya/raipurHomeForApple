import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/Skeletons/notificationSkeleton.dart';
import 'package:fmraipuromes/screens/MainHome/viewModal/mainHomeViewModal.dart';
import 'package:fmraipuromes/screens/Notification/viewModel/notificationViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/color.dart';
import '../../Drawer/view/mainDrawerNew.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  _firstLoad() async {
    if (mounted) {
      final notificationsViewModel =
          Provider.of<NotificationViewModel>(context, listen: false);
      notificationsViewModel.getNotification();
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mainHomeController = Provider.of<MainHomeViewViewModal>(context);
    final notificationsViewModel = Provider.of<NotificationViewModel>(context);
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
            "Notification",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: textColor2),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: InkWell(
          //       onTap: () {
          //         // Navigator.pop(context);
          //       },
          //       child: const Icon(
          //         CupertinoIcons.clear_circled,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: notificationsViewModel.isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade50,
                child: const NotificationSkeleton())
            : notificationsViewModel.notificationDataModel.data?.length == 0
                ? Center(child: Lottie.asset("assets/gif/noData.json"))
                : ListView.builder(
                    itemCount: notificationsViewModel
                            .notificationDataModel.data?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return FadeInLeft(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            title: Text(
                              notificationsViewModel
                                      .notificationDataModel.data?[index].title
                                      .toString() ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                                notificationsViewModel.notificationDataModel
                                        .data?[index].descriptions
                                        .toString() ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: subTitleColor,
                                    )),
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/png/rprHomeLogo.png"),
                            ),
                            onTap: () {
                              // Handle notification tap
                            },
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}