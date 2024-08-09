import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:gap/gap.dart';

class BlogViewCard extends StatelessWidget {
  final String blogDate;
  final String title;
  final String image;
  final String description;
  final VoidCallback? onTap;

  const BlogViewCard({
    super.key,
    required this.size,
    required this.blogDate,
    required this.title,
    required this.image,
    required this.description,
    this.onTap,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(width: 1, color: secondaryColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  height: size.height * 0.25,
                  fit: BoxFit.fill,
                  imageUrl: image,
                  // "https://www.raipurhomes.com/uploads/blog/43331720932311.jpg",
                  placeholder: (context, url) {
                    return Image.asset(
                        fit: BoxFit.cover, "assets/png/rprHomeLogo.png");
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(
                        fit: BoxFit.cover, "assets/png/rprHomeLogo.png");
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.grey,
                    ),
                    RichText(
                        text: TextSpan(
                            // text: "July 14th, 2024 in",
                            text: blogDate,
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
                                    fontWeight: FontWeight.w600),
                          ),
                        ]))
                  ],
                ),
                const Gap(10.0),
                InkWell(
                  onTap: onTap,
                  child: Text(
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    title,
                    // "DOORSTEP-VERIFICATION-SERVICES-ENSURING-SECURE-PROPERTY-TRANSACTIONS-IN-RAIPUR-CHHATTISGARH",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: textColor2),
                  ),
                ),
                const Gap(10.0),
                HtmlWidget(
                  description.length > 300
                      ? description.substring(0, 300) + '...'
                      : description,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.grey),
                ),
                // Text(
                //   maxLines: 7,
                //   textAlign: TextAlign.justify,
                //   overflow: TextOverflow.ellipsis,
                //   description,
                //   // "Navigating the complexities of real estate transactions in Raipur, Chhattisgarh, requires informed decisions and strategic planning. Whether you're a buyer, seller, or investor, seeking professional consultation services can provide valuable insights and guidance to achieve your real estate goals effectively. This article explores the consultation services offered by RaipurHomes.com and",
                //   style: Theme.of(context)
                //       .textTheme
                //       .labelSmall!
                //       .copyWith(color: Colors.grey),
                // ),
                const Gap(10.0),
                InkWell(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        maxLines: 4,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        "Continue",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: accentColor),
                      ),
                      Icon(
                        Icons.double_arrow_outlined,
                        size: 20,
                        color: accentColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
