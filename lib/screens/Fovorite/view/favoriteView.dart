import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/repository/bookMarkController.dart';
import 'package:fmraipuromes/screens/Drawer/view/mainDrawerNew.dart';
import 'package:fmraipuromes/screens/MainHome/viewModal/mainHomeViewModal.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/color.dart';
import '../../../repository/getFilterTools.dart';
import '../../../utils/DraggableModalBottomSheet.dart';
import '../../../utils/FeaturePropertyRecommended.dart';
import '../../Profile/viewModel/profileViewModel.dart';
import '../../SubPages/Support/supportViewModel.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  _firstLoad() async {
    final bookMarkController =
        Provider.of<BookMarkController>(context, listen: false);
    if (mounted) {
      bookMarkController.getBookMarkedData();
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _onRefresh() async {
    _firstLoad();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Menu
  void _showDraggableModalSheet(
      BuildContext context, String title, int itemCount) {
    final profileViewController =
        Provider.of<ProfileViewModel>(context, listen: false);
    final filterToolViewModel =
        Provider.of<GetFilterTools>(context, listen: false);
    final supportViewController =
        Provider.of<SupportViewModel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableModalBottomSheet(
          title: title,
          itemCount: itemCount,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final mainHomeController = Provider.of<MainHomeViewViewModal>(context);
    final bookMarkController = Provider.of<BookMarkController>(context);
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
              // decoration: BoxDecoration(gradient: defaultGradient3),
              ),
          // backgroundColor: secondaryColor,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: borderColor)),
              child: InkWell(
                  onTap: () =>
                      _showDraggableModalSheet(context, 'Home Menu', 20),
                  child: Icon(
                    Icons.menu,
                    color: iconColor,
                  )),
            ),
          ),
          title: Text(
            "Favourite Properties",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: textColor,
                ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: bookMarkController.isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade50,
                  child: const ListViewBuilderSkeleton())
              : bookMarkController.allPropertyModel.data?.length == 0
                  ? Center(child: Lottie.asset("assets/gif/noData.json"))
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          bookMarkController.allPropertyModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return FadeInDown(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.propertyDetailView,
                                  arguments: bookMarkController
                                      .allPropertyModel.data?[index].serviceId
                                      .toString());
                            },
                            child: FavoriteCard(
                              isLoading: bookMarkController
                                  .allPropertyModel.data?[index].loading,
                              propertyType: bookMarkController
                                      .allPropertyModel
                                      .data?[index]
                                      .getapiCategories
                                      ?.categoriesName
                                      .toString() ??
                                  "",
                              onTapFav: () {
                                bookMarkController.setIsFav(
                                    bookMarkController.allPropertyModel
                                            .data?[index].serviceId
                                            .toString() ??
                                        "",
                                    index);
                                _firstLoad();
                              },
                              isFav: bookMarkController.allPropertyModel
                                          .data?[index].getBookMarkedProperty !=
                                      null
                                  ? true
                                  : false,
                              size: size,
                              image:
                                  "${AppUrl.baseUrl}${bookMarkController.allPropertyModel.data?[index].featureImage ?? ""}",
                              title: bookMarkController
                                      .allPropertyModel.data?[index].title
                                      .toString() ??
                                  "",
                              address: bookMarkController
                                      .allPropertyModel.data?[index].address
                                      .toString() ??
                                  "",
                              type: bookMarkController.allPropertyModel
                                      .data?[index].getapiPropertySubType?.name
                                      .toString() ??
                                  "",
                              price: bookMarkController
                                      .allPropertyModel.data?[index].pricing
                                      .toString() ??
                                  "",
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
