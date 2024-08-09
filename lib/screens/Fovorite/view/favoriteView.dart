import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/repository/bookMarkController.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/FeaturePropertyRecommended.dart';

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

  Future<void> _onRefresh() async {
    _firstLoad();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bookMarkController = Provider.of<BookMarkController>(context);
    return Scaffold(
      appBar: const NormalAppBar(title: "Favorite Properties"),
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
    );
  }
}
