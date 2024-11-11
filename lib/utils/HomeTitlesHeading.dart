import 'package:flutter/material.dart';

import '../constant/color.dart';

class HomeTitlesHeading extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const HomeTitlesHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // "Popular property",
            title,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: accentColor, fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              // "View all",
              subtitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: textColor3),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeTitlesCenterHeading extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const HomeTitlesCenterHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // "Popular property",
            title,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: textColor, fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              // "View all",
              subtitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

class SubPageTitlesHeading extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const SubPageTitlesHeading({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // "Popular property",
            title,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: accentColor, fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              // "View all",
              subtitle ?? "",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: textColor3, fontSize: 13.0),
            ),
          ),
        ],
      ),
    );
  }
}

class SubPageTitlesHeading2 extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const SubPageTitlesHeading2({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          // "Popular property",
          title,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: textColor2, fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            // "View all",
            subtitle ?? "",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: textColor3, fontSize: 13.0),
          ),
        ),
      ],
    );
  }
}

class SubPageTitlesHeading3 extends StatelessWidget {
  final String title;
  final bool mandatory;
  final String? subtitle;
  final VoidCallback? onTap;

  const SubPageTitlesHeading3({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.mandatory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
            text: TextSpan(
                text: title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: textColor2, fontWeight: FontWeight.w600),
                children: [
              TextSpan(
                  text: mandatory ? " *" : "",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: errorColor, fontWeight: FontWeight.w600)),
            ])),
        InkWell(
          onTap: onTap,
          child: Text(
            // "View all",
            subtitle ?? "",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: textColor3, fontSize: 13.0),
          ),
        ),
      ],
    );
  }
}
