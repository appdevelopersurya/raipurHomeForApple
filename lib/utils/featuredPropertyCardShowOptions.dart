import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:gap/gap.dart';

class FeaturedPropertyCardShowOptions extends StatelessWidget {
  final Size size;
  final String? forSale;
  final String? type;
  final String? subType;
  final String? floorType;
  final String? priceType;
  final String? constructionSize;
  final String? openSide;
  final String? propertyFace;
  final String? propertyInterior;
  final String? flatType;

  const FeaturedPropertyCardShowOptions({
    super.key,
    this.forSale,
    this.type,
    this.subType,
    this.floorType,
    this.priceType,
    this.constructionSize,
    this.openSide,
    this.propertyFace,
    this.propertyInterior,
    this.flatType,
    required this.size,
  });

  MainAxisAlignment determineMainAxisAlignment() {
    bool hasConstructionSize = constructionSize != null &&
        constructionSize != "null" &&
        constructionSize != "0";
    bool hasPropertyFace =
        propertyFace != null && propertyFace != "null" && propertyFace != "0";
    bool hasOpenSide =
        openSide != null && openSide != "null" && openSide != "0";

    if (hasConstructionSize || hasPropertyFace || hasOpenSide) {
      return MainAxisAlignment.spaceEvenly;
    } else {
      return MainAxisAlignment.start; // Default case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Size
          Visibility(
            visible: constructionSize != null &&
                constructionSize != "null" &&
                constructionSize != "" &&
                constructionSize != "0",
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blueGrey.shade50,
                  child: SvgPicture.asset(
                    "assets/svg/rSize.svg",
                    height: 18,
                    width: 18,
                    color: textColor6,
                  ),
                ),
                const Gap(5),
                Text(
                  constructionSize ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: textColor6, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Gap(10.0),

          // For Sale Condition
          if (forSale == "Sell" || forSale == "For Sell") ...[
            // Property Face
            const Gap(10.0),
            Visibility(
              visible: propertyFace != null &&
                  propertyFace != "null" &&
                  propertyFace != "" &&
                  propertyFace != "0",
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blueGrey.shade50,
                    child: Icon(
                      CupertinoIcons.compass_fill,
                      size: 18,
                      color: textColor6,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    propertyFace ?? "",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: textColor6, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Gap(10.0),
            // Open Side for Plot
            if (subType == 'Plot' || subType == 'plot') ...[
              Visibility(
                visible: openSide != null &&
                    openSide != "null" &&
                    openSide != "" &&
                    openSide != "0",
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blueGrey.shade50,
                      child: Icon(
                        CupertinoIcons.compass_fill,
                        size: 18,
                        color: textColor6,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      openSide ?? "",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: textColor6, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
            // Floor Type for House
            if (subType == 'House' || subType == 'house') ...[
              const Gap(10.0),
              Visibility(
                visible: floorType != null &&
                    floorType != "null" &&
                    floorType != "" &&
                    floorType != "0",
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blueGrey.shade50,
                      child: Icon(
                        Icons.offline_share_sharp,
                        size: 18,
                        color: textColor6,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      floorType ?? "",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: textColor6, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ],

          // Property Interior
          if (forSale != "Sell" && forSale != "For Sell") ...[
            const Gap(10.0),
            Visibility(
              visible: propertyInterior != null &&
                  propertyInterior != "null" &&
                  propertyInterior != "" &&
                  propertyInterior != "0",
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blueGrey.shade50,
                    child: Icon(
                      Icons.room_preferences_outlined,
                      size: 18,
                      color: textColor6,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    propertyInterior ?? "",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: textColor6, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Gap(10.0),
            // Flat Type
            Visibility(
              visible: flatType != null &&
                  flatType != "null" &&
                  flatType != "" &&
                  !flatType!.contains("0"),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blueGrey.shade50,
                    child: Icon(
                      Icons.offline_share_sharp,
                      size: 18,
                      color: textColor6,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    flatType ?? "",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: textColor6, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Sale 5
// Rent 3

// : (subType == "Plot" || subType == "plot")
//     ? Visibility(
//         visible: openSide != "null" &&
//             openSide != null &&
//             openSide != "" &&
//             openSide != "0",
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 16,
//               backgroundColor: Colors.blueGrey.shade50,
//               child: Icon(
//                 Icons.maps_home_work_outlined,
//                 size: 18,
//                 color: textColor6,
//               ),
//             ),
//             const SizedBox(width: 5),
//             Text(
//               openSide.toString(),
//               style: Theme.of(context)
//                   .textTheme
//                   .labelSmall!
//                   .copyWith(color: textColor6),
//             ),
//           ],
//         ),
//       )
//     : (subType == "House" || subType == "house")
//         ? Visibility(
//             visible: floorType != "null" &&
//                 floorType != null &&
//                 floorType != "" &&
//                 floorType != "0",
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundColor: Colors.blueGrey.shade50,
//                   child: Icon(
//                     Icons.maps_home_work_outlined,
//                     size: 18,
//                     color: textColor6,
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   flatType.toString(),
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelSmall!
//                       .copyWith(color: textColor6),
//                 ),
//               ],
//             ),
//           )
//         : const Offstage()
// else
//   Visibility(
//     visible: propertyInterior != "null" &&
//         propertyInterior != null &&
//         propertyInterior != "" &&
//         propertyInterior != "0",
//     child: Row(
//       children: [
//         CircleAvatar(
//           radius: 16,
//           backgroundColor: Colors.blueGrey.shade50,
//           child: Icon(
//             Icons.maps_home_work_outlined,
//             size: 18,
//             color: textColor6,
//           ),
//         ),
//         const SizedBox(width: 5),
//         Text(
//           propertyInterior.toString(),
//           style: Theme.of(context)
//               .textTheme
//               .labelSmall!
//               .copyWith(color: textColor6),
//         ),
//       ],
//     ),
//   ),
// const Gap(10.0),
// Visibility(
//   visible: flatType != "null" &&
//       flatType != null &&
//       flatType != "" &&
//       !flatType!.contains("0"),
//   child: Row(
//     children: [
//       CircleAvatar(
//         radius: 16,
//         backgroundColor: Colors.blueGrey.shade50,
//         child: Icon(
//           CupertinoIcons.compass_fill,
//           size: 18,
//           color: textColor6,
//         ),
//       ),
//       const SizedBox(width: 5),
//       Text(
//         flatType.toString(),
//         style: Theme.of(context)
//             .textTheme
//             .labelSmall!
//             .copyWith(color: textColor6),
//       ),
//     ],
//   ),
// )
