import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/routes/routes.dart';
import '../../../../constant/color.dart';
import '../../../../data/modal/passFilterModel.dart';
import '../../../../services/apis/app_url.dart';
import '../../../../utils/NormalAppBar.dart';
import '../viewModel/OurProjectsViewsModel.dart';

class OurProjectsListView extends StatefulWidget {
  const OurProjectsListView({super.key});

  @override
  State<OurProjectsListView> createState() => _OurProjectsListViewState();
}

class _OurProjectsListViewState extends State<OurProjectsListView> {
  _firstLoad() {
    final ourProjectController =
        Provider.of<OurProjectsViewModel>(context, listen: false);
    if (mounted) {
      ourProjectController.getProjectListForPage();
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ourProjectController = Provider.of<OurProjectsViewModel>(
      context,
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const NormalAppBar(
          title: "Our Projects",
        ),
        body: ourProjectController.isLodingDetailsPage == true
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: const ListViewBuilderSkeleton())
            : ListView.builder(
                itemCount:
                    ourProjectController.ourProjectDataModels.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return FadeInDown(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  height: size.height * 0.3,
                                  width: size.width,
                                  imageUrl:
                                      "${AppUrl.baseUrl}${ourProjectController.ourProjectDataModels.data?[index].projectImage.toString() ?? ""}",
                                  // "https://www.raipurhomes.com/public/project_images/1725609092RADHE-KRISHNA--2.jpg",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      "assets/png/rprNewLogo.png",
                                      height: size.height * 0.3,
                                      width: size.width,
                                    );
                                  },
                                ),
                              ),
                              const Gap(10.0),
                              Text(
                                textAlign: TextAlign.left,
                                ourProjectController.ourProjectDataModels
                                        .data?[index].projectName
                                        .toString() ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: accentColor),
                              ),
                              const Gap(10.0),
                              HtmlWidget(
                                ourProjectController.ourProjectDataModels
                                        .data?[index].discription
                                        .toString() ??
                                    "",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: textColor3.withOpacity(0.7)),
                              ),
                              const Gap(10.0),
                              const Divider(),
                              Row(
                                children: [
                                  Icon(Icons.home,
                                      size: 18,
                                      color: textColor3.withOpacity(0.7)),
                                  Text(
                                    " ${ourProjectController.ourProjectDataModels.data?[index].totalPost?.length ?? ""} properties",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: textColor3.withOpacity(0.7)),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.ourProjects,
                                          arguments: PassFilterModel(
                                              id: ourProjectController
                                                      .ourProjectDataModels
                                                      .data?[index]
                                                      .id
                                                      ?.toInt() ??
                                                  0,
                                              title: ourProjectController
                                                      .ourProjectDataModels
                                                      .data?[index]
                                                      .projectName
                                                      .toString() ??
                                                  "",
                                              logLate: "singleLocation"));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: textColor3.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 2.0, 5.0, 2.0),
                                        child: Text(
                                          "View",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: textColor3),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
