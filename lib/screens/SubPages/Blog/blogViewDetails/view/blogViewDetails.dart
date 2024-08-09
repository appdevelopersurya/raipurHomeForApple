import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fmraipuromes/Skeletons/PropertyDetailsSkeleton.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/screens/SubPages/Blog/blogViewDetails/viewModel/blogDetailsViewMocel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/BlogViewCard.dart';
import 'package:fmraipuromes/utils/FeaturePropertyRecommended.dart';
import 'package:fmraipuromes/utils/HomeTitlesHeading.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constant/color.dart';

class BlogViewDetails extends StatefulWidget {
  final String? blogId;

  const BlogViewDetails({super.key, this.blogId});

  @override
  State<BlogViewDetails> createState() => _BlogViewDetailsState();
}

class _BlogViewDetailsState extends State<BlogViewDetails> {
  final GlobalKey _sliverAppBarKey = GlobalKey();
  late ScrollController _scrollController;
  bool _isPinned = false;

  _firstLoad() {
    if (mounted) {
      final blogDetailsViewModel =
          Provider.of<BlogDetailsViewModel>(context, listen: false);
      blogDetailsViewModel.getBlogDetails(false, widget.blogId.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _initializeScrollController();
  }

  void _initializeScrollController() {
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _isPinned = _scrollController.hasClients &&
          _scrollController.offset >=
              (_scrollController.position.minScrollExtent + 200);
      // if (_isPinned == false) {
      //   _isPinned = true;
      // } else {
      //   _isPinned = false;
      // }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Remove listener
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final blogDetailsViewModel = Provider.of<BlogDetailsViewModel>(context);
    return Scaffold(
      // appBar: NormalAppBar(title: "Blog Details"),
      body: blogDetailsViewModel.isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: PropertyDetailsSkeleton(
                size: size,
              ))
          : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  key: _sliverAppBarKey,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        backgroundColor: _isPinned == true
                            ? Colors.transparent
                            : Colors.white24,
                        child: Icon(
                          Icons.arrow_back,
                          color:
                              _isPinned == true ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  pinned: _isPinned,
                  expandedHeight: size.height * 0.35,
                  backgroundColor: const Color(0xFFf3ef66),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 1.0, end: 0.0),
                      duration: const Duration(milliseconds: 500),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return Transform.scale(
                          scale: 1 + value, // Scale factor for the title
                          child: Opacity(
                            opacity: 1 - value, // Opacity factor for the title
                            child: Text('Blog Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: _isPinned == true
                                            ? Colors.black
                                            : Colors.white)),
                          ),
                        );
                      },
                    ),
                  ),
                  // title: Text('Blog Details',
                  //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  //         color: _isPinned == true ? Colors.black : Colors.white)),
                  centerTitle: false,
                  // Set the height of the header when expanded
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // Add the background image
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${AppUrl.baseUrl}${blogDetailsViewModel.blogDetailsDataModel.data?.image?.toString() ?? ""}",
                          placeholder: (context, url) {
                            return Image.asset(
                                fit: BoxFit.cover,
                                "assets/png/rprHomeLogo.png");
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(
                                fit: BoxFit.cover,
                                "assets/png/rprHomeLogo.png");
                          },
                        ),
                        // Add the overlay with opacity
                        Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        // Add the title with scaling and fading effect
                      ],
                    ),
                  ),
                  // Other properties like pinned, floating, elevation, etc.
                  // can be customized as needed
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                "${blogDetailsViewModel.blogDetailsDataModel.data?.blogDate?.toString() ?? ""} in",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: Colors.grey),
                                            children: [
                                          TextSpan(
                                            text: " Latest blog , service",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ]))
                                  ],
                                ),
                                Gap(10.0),
                                Text(
                                  textAlign: TextAlign.justify,
                                  blogDetailsViewModel
                                          .blogDetailsDataModel.data?.title
                                          ?.toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: textColor2),
                                ),
                                const Gap(10.0),
                                HtmlWidget(
                                  blogDetailsViewModel.blogDetailsDataModel.data
                                          ?.description ??
                                      "",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: Colors.grey),
                                ),
                                const Gap(10.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const HomeTitlesHeading(title: "Related Posts"),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: blogDetailsViewModel
                                          .blogDetailsDataModel
                                          .relatedBlog
                                          ?.length ??
                                      0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return FadeInRight(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 3, 8.0, 3),
                                        child: BlogViewCard(
                                          onTap: () => Navigator.pushNamed(
                                            context,
                                            AppRoutes.blogViewDetails,
                                            arguments: blogDetailsViewModel
                                                    .blogDetailsDataModel
                                                    .relatedBlog?[index]
                                                    .id ??
                                                "",
                                          ),
                                          size: size,
                                          title: blogDetailsViewModel
                                                  .blogDetailsDataModel
                                                  .relatedBlog?[index]
                                                  .title ??
                                              "",
                                          image:
                                              "${AppUrl.baseUrl}${blogDetailsViewModel.blogDetailsDataModel.relatedBlog?[index].image ?? ""}",
                                          description: blogDetailsViewModel
                                                  .blogDetailsDataModel
                                                  .relatedBlog?[index]
                                                  .description ??
                                              "",
                                          blogDate: blogDetailsViewModel
                                                  .blogDetailsDataModel
                                                  .relatedBlog?[index]
                                                  .blogDate ??
                                              "",
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const HomeTitlesHeading(title: "Recent Posts"),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: blogDetailsViewModel
                                          .blogDetailsDataModel
                                          .recentBlog
                                          ?.length ??
                                      0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return FadeInRight(
                                      child: InkWell(
                                        onTap: () => Navigator.pushNamed(
                                            context, AppRoutes.blogViewDetails,
                                            arguments: blogDetailsViewModel
                                                    .blogDetailsDataModel
                                                    .recentBlog?[index]
                                                    .id
                                                    .toString() ??
                                                ""),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 8.0, 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: CachedNetworkImage(
                                                      height: 70,
                                                      width: 70,
                                                      fit: BoxFit.fill,
                                                      imageUrl:
                                                          "${AppUrl.baseUrl}${blogDetailsViewModel.blogDetailsDataModel.recentBlog?[index].image ?? ""}",
                                                      placeholder:
                                                          (context, url) {
                                                        return SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: accentColor,
                                                          ),
                                                        );
                                                      },
                                                      errorWidget: (context,
                                                          url, error) {
                                                        return Image.asset(
                                                            fit: BoxFit.cover,
                                                            "assets/png/rprHomeLogo.png");
                                                      },
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          blogDetailsViewModel
                                                                  .blogDetailsDataModel
                                                                  .recentBlog?[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelMedium!
                                                              .copyWith(
                                                                  color:
                                                                      textColor2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: HtmlWidget(
                                                          (blogDetailsViewModel
                                                                          .blogDetailsDataModel
                                                                          .recentBlog?[
                                                                              index]
                                                                          .description
                                                                          ?.length ??
                                                                      0) >
                                                                  300
                                                              ? blogDetailsViewModel
                                                                      .blogDetailsDataModel
                                                                      .recentBlog![
                                                                          index]
                                                                      .description!
                                                                      .substring(
                                                                          0,
                                                                          50) +
                                                                  '...'
                                                              : blogDetailsViewModel
                                                                      .blogDetailsDataModel
                                                                      .recentBlog?[
                                                                          index]
                                                                      .description ??
                                                                  "",
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const HomeTitlesHeading(title: "Featured properties"),
                      SizedBox(
                        height: size.height * 0.23,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: blogDetailsViewModel
                                  .blogDetailsDataModel.property?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return FadeInRight(
                              child: FeaturePropertyRecommended(
                                size: size,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.propertyDetailView,
                                  arguments: blogDetailsViewModel
                                          .blogDetailsDataModel
                                          .property?[index]
                                          .serviceId
                                          .toString() ??
                                      "",
                                ),
                                title: blogDetailsViewModel.blogDetailsDataModel
                                        .property?[index].title
                                        .toString() ??
                                    "",
                                address: blogDetailsViewModel
                                        .blogDetailsDataModel
                                        .property?[index]
                                        .jioLocation
                                        .toString() ??
                                    "",
                                propertyType: blogDetailsViewModel
                                        .blogDetailsDataModel
                                        .property?[index]
                                        .getapiCategories
                                        ?.categoriesName
                                        .toString() ??
                                    "",
                                type: "",
                                image:
                                    "${AppUrl.baseUrl}${blogDetailsViewModel.blogDetailsDataModel.property?[index].featureImage.toString() ?? ""}",
                                price: blogDetailsViewModel.blogDetailsDataModel
                                        .property?[index].pricing
                                        .toString() ??
                                    "",
                                priceType: blogDetailsViewModel
                                        .blogDetailsDataModel
                                        .property?[index]
                                        .pricetype
                                        .toString() ??
                                    "",
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
