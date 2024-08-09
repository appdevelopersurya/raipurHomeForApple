import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/Skeletons/ListViewSkelton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/screens/SubPages/Blog/viewModel/blogViewModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/BlogViewCard.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  _firstLoad() {
    if (mounted) {
      final blogViewModel = Provider.of<BlogViewModel>(context, listen: false);
      blogViewModel.getBlogList(false);
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  Future<void> _onRefresh() async {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => _firstLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final blogViewModel = Provider.of<BlogViewModel>(context);

    return Scaffold(
      appBar: const NormalAppBar(title: "Raipur Home Blogs"),
      body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: blogViewModel.isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const ListViewBuilderSkeleton())
              : ListView.builder(
                  itemCount: blogViewModel.blogListDataModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return FadeInRight(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlogViewCard(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.blogViewDetails,
                              arguments: blogViewModel
                                      .blogListDataModel.data?[index].id
                                      .toString() ??
                                  ""),
                          size: size,
                          title: blogViewModel
                                  .blogListDataModel.data?[index].title
                                  .toString() ??
                              "",
                          image:
                              "${AppUrl.baseUrl}${blogViewModel.blogListDataModel.data?[index].image}" ??
                                  "",
                          description:
                              "${blogViewModel.blogListDataModel.data?[index].description.toString() ?? ""} in",
                          blogDate: blogViewModel
                                  .blogListDataModel.data?[index].blogDate
                                  .toString() ??
                              "",
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
