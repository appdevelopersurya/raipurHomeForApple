import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/passFilterModel.dart';
import 'package:fmraipuromes/helper/amounFormatter.dart';
import 'package:fmraipuromes/repository/getFilterTools.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../repository/getFilterTools.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextEditingController locSearchController = TextEditingController();

  _fetchFilterData() {
    final filterController =
        Provider.of<GetFilterTools>(context, listen: false);
    if (mounted) {
      filterController.fetchFilterTools();
    }
  }

  @override
  void initState() {
    _fetchFilterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterController = Provider.of<GetFilterTools>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        filterController.clearAllFilters();
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeMain,
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 1,
          centerTitle: true,
          title: Text(
            "Property Filter",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: buttonTextColor),
          ),
          leading: InkWell(
            onTap: () {
              filterController.clearAllFilters();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeMain,
                (route) => false,
              );
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            const Gap(10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(width: 1, color: borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.checkmark_shield_fill,
                            size: 18,
                            color: Colors.green.withOpacity(0.6),
                          ),
                          Text(
                            "BUY",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Radio(
                            activeColor: Colors.red,
                            value: 5,
                            groupValue: filterController.isVerified,
                            onChanged: (value) {
                              _fetchFilterData();
                              filterController.setIsVerified(value!);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(20.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(width: 1, color: borderColor)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 18,
                            color: Colors.orange,
                          ),
                          Text(
                            "RENT",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Radio(
                            activeColor: Colors.red,
                            value: 3,
                            groupValue: filterController.isVerified,
                            onChanged: (value) {
                              _fetchFilterData();
                              filterController.setIsVerified(value!);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10.0),
            filterController.isVerified == 5
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PRICE RANGE",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SfRangeSlider(
                          activeColor: Colors.red,
                          min: 500000.0,
                          max: 50000000.0,
                          values: filterController.valuesPriceBuy,
                          stepSize: 500000,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 1,
                          dividerShape: const SfDividerShape(),
                          showDividers: true,
                          tooltipTextFormatterCallback:
                              (actualValue, formattedText) {
                            return Formatter.formatNumber(
                                actualValue.toString());
                          },
                          labelFormatterCallback: (actualValue, formattedText) {
                            return Formatter.formatNumber(
                                actualValue.toString());
                          },
                          onChanged: (SfRangeValues values) {
                            filterController.setRangeValueForBuy(values);
                          },
                        ),
                        const Gap(10.0),
                        filterController.priceRangeValueBuy1 < 1
                            ? const Offstage()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "PRICE  ${Formatter.formatNumber(filterController.priceRangeValueBuy1.toString())} - ${Formatter.formatNumber(filterController.priceRangeValueBuy2.toString())}",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  )
                                ],
                              )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PRICE RANGE",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SfRangeSlider(
                          activeColor: Colors.red,
                          min: 5000.0,
                          max: 500000.0,
                          values: filterController.valuesPriceRent,
                          stepSize: 50000,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 1,
                          tooltipTextFormatterCallback:
                              (actualValue, formattedText) {
                            return Formatter.formatNumber(
                                actualValue.toString());
                          },
                          labelFormatterCallback: (actualValue, formattedText) {
                            return Formatter.formatNumber(
                                actualValue.toString());
                          },
                          onChanged: (SfRangeValues values) {
                            filterController.setRangeValueForRent(values);
                          },
                        ),
                        const Gap(10.0),
                        filterController.priceRangeValueRent1 < 1
                            ? const Offstage()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "PRICE  ${Formatter.formatNumber(filterController.priceRangeValueRent1.toString())} - ${Formatter.formatNumber(filterController.priceRangeValueRent2.toString())}",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AREA SIZE (SQ.FT.)",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SfRangeSlider(
                    activeColor: Colors.red,
                    min: 500.0,
                    max: 30000.0,
                    values: filterController.valuesAreaRange,
                    stepSize: 1000,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    labelFormatterCallback: (actualValue, formattedText) {
                      if (actualValue == 30000.0) {
                        return '$formattedText+';
                      } else {
                        return formattedText;
                      }
                    },
                    onChanged: (SfRangeValues values) {
                      filterController.setAreaValue(values);
                    },
                  ),
                  const Gap(10.0),
                  filterController.areaRangeValue1 < 1
                      ? const Offstage()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "AREA (SQ.FT.) ${filterController.areaRangeValue1.toInt()} - ${filterController.areaRangeValue2.toInt()}",
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          ],
                        )
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AREA KM UPTO",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SfRangeSlider(
                    activeColor: Colors.red,
                    min: 0.0,
                    max: 5.0,
                    values: filterController.valuesAreaRangeKm,
                    stepSize: 1,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      filterController.setAreaKmValue(values);
                    },
                  ),
                  const Gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "AREA KM UPTO ${filterController.areaRangeKm1.toInt()} - ${filterController.areaRangeKm2.toInt()}",
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  )
                ],
              ),
            ),
            // //Where,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                title: Text(
                  "LOCATIONS",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1, color: borderColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            filterController.filterLocationSearch(value);
                          },
                          style: Theme.of(context).textTheme.labelSmall,
                          decoration: InputDecoration(
                            hintText: "Search Town",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: hintColor),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: filterController.locations.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            filterController.toggleSelectedArea(
                              filterController.locations[index].id.toString() ??
                                  "",
                              filterController.locations[index].name.toString(),
                            );
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: filterController.isSelectedArea(
                                      filterController.locations[index].id
                                              .toString() ??
                                          "",
                                    ) ??
                                    false,
                                onChanged: (bool? value) {
                                  filterController.toggleSelectedArea(
                                    filterController.locations[index].id
                                            .toString() ??
                                        "",
                                    filterController.locations[index].name
                                        .toString(),
                                  );
                                },
                                checkColor: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                filterController.locations[index].name
                                        .toString() ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontSize: 12.0, color: textColor3),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (filterController.selectedAreaName.isNotEmpty)
                    Column(
                      children: [
                        const Gap(10.0),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            itemCount: filterController.selectedAreaName.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final locationName =
                                  filterController.selectedAreaName[index];
                              final id = filterController.selectedAreas[index];

                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: textColor3,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "$locationName",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: buttonTextColor),
                                        ),
                                        const Gap(5.0),
                                        InkWell(
                                          onTap: () {
                                            filterController.toggleSelectedArea(
                                                id, locationName);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: buttonTextColor,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Gap(5.0),
                      ],
                    ),
                ],
              ),
            ),

            //Property Type,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                  title: Text(
                    "PROPERTY TYPE",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filterController
                                .filterToolsDataModel.type?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedSubPropertyType(
                                  filterController
                                          .filterToolsDataModel.type?[index].id
                                          .toString() ??
                                      "");
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController
                                          .isSelectedSubPropertyType(
                                              filterController
                                                      .filterToolsDataModel
                                                      .type?[index]
                                                      .id
                                                      .toString() ??
                                                  "") ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController
                                        .toggleSelectedSubPropertyType(
                                            filterController
                                                    .filterToolsDataModel
                                                    .type?[index]
                                                    .id
                                                    .toString() ??
                                                "");
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.filterToolsDataModel
                                          .type?[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12.0, color: textColor3),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
            //Property sub Types,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                  title: Text(
                    "SUB TYPE",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1, color: borderColor)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            onChanged: (value) {
                              filterController.filterPropertyTypeSearch(value);
                            },
                            style: Theme.of(context).textTheme.labelSmall,
                            decoration: InputDecoration(
                              hintText: "Search Sub Property Type",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: hintColor),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filterController
                                .filterToolsDataModel.propertyType?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedPropertyType(
                                  filterController.filterToolsDataModel
                                          .propertyType?[index].id
                                          .toString() ??
                                      "",
                                  filterController.filterToolsDataModel
                                          .propertyType?[index].name
                                          .toString() ??
                                      "");
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController.isSelectedPType(
                                          filterController.filterToolsDataModel
                                                  .propertyType?[index].id
                                                  .toString() ??
                                              "") ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController.toggleSelectedPropertyType(
                                        filterController.filterToolsDataModel
                                                .propertyType?[index].id
                                                .toString() ??
                                            "",
                                        filterController.filterToolsDataModel
                                                .propertyType?[index].name
                                                .toString() ??
                                            "");
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.filterToolsDataModel
                                          .propertyType?[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12.0, color: textColor3),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Gap(filterController.selectedPropertyTypeName.length != 0
                        ? 10.0
                        : 0.0),
                    filterController.selectedPropertyTypeName.length != 0
                        ? SizedBox(
                            height: 40,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              itemCount: filterController
                                  .selectedPropertyTypeName.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final subPTypeName = filterController
                                    .selectedPropertyTypeName[index];
                                final id = filterController
                                    .selectedPropertyType[index];
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: textColor3),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "$subPTypeName",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: buttonTextColor),
                                            ),
                                            const Gap(5.0),
                                            InkWell(
                                              onTap: () {
                                                filterController
                                                    .toggleSelectedPropertyType(
                                                        id, subPTypeName);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: buttonTextColor,
                                                size: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                          )
                        : const Offstage(),
                    Gap(filterController.selectedAreaName.length != 0
                        ? 5.0
                        : 0.0),
                  ]),
            ),
            //By Builder,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                  title: Text(
                    "BY BUILDER",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filterController
                                .filterToolsDataModel.builders?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedByBuilder(
                                  filterController.filterToolsDataModel
                                          .builders?[index].id
                                          .toString() ??
                                      "");
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController.isSelectedByBuilder(
                                          filterController.filterToolsDataModel
                                                  .builders?[index].id
                                                  .toString() ??
                                              "") ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController.toggleSelectedByBuilder(
                                        filterController.filterToolsDataModel
                                                .builders?[index].id
                                                .toString() ??
                                            "");
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.filterToolsDataModel
                                          .builders?[index].name
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12.0, color: textColor3),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
            //BHK type
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                  title: Text(
                    "BHK TYPE",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filterController
                                .filterToolsDataModel.bhkType?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedBHKType(
                                  filterController.filterToolsDataModel
                                          .bhkType?[index].flattype ??
                                      "0");
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController.isSelectedBHKType(
                                          filterController.filterToolsDataModel
                                                  .bhkType?[index].flattype ??
                                              "0") ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController.toggleSelectedBHKType(
                                        filterController.filterToolsDataModel
                                                .bhkType?[index].flattype ??
                                            "");
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController.filterToolsDataModel
                                          .bhkType?[index].flattype
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12.0, color: textColor3),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),

            //CONSTRUCTION STATUS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                  title: Text(
                    "PROPERTY STATUS",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filterController
                                .filterToolsDataModel.construction?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedConstructionType(
                                  filterController
                                          .filterToolsDataModel
                                          .construction?[index]
                                          .constructionstatus ??
                                      "");
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController
                                          .isSelectedConstructionType(
                                              filterController
                                                      .filterToolsDataModel
                                                      .construction?[index]
                                                      .constructionstatus ??
                                                  "") ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController
                                        .toggleSelectedConstructionType(
                                            filterController
                                                    .filterToolsDataModel
                                                    .construction?[index]
                                                    .constructionstatus ??
                                                "");
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController
                                          .filterToolsDataModel
                                          .construction?[index]
                                          .constructionstatus
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12.0, color: textColor3),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),

            //CONSTRUCTION STATUS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpansionTile(
                  title: Text(
                    "PROPERTY INTERIOR",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filterController.filterToolsDataModel
                                .propertyInterior?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              filterController.toggleSelectedPropertyInterior(
                                  filterController
                                          .filterToolsDataModel
                                          .propertyInterior?[index]
                                          .propertyinterior ??
                                      "");
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: filterController
                                          .isSelectedPropertyInterior(
                                              filterController
                                                      .filterToolsDataModel
                                                      .propertyInterior?[index]
                                                      .propertyinterior ??
                                                  "") ??
                                      false,
                                  onChanged: (bool? value) {
                                    filterController
                                        .toggleSelectedPropertyInterior(
                                            filterController
                                                    .filterToolsDataModel
                                                    .propertyInterior?[index]
                                                    .propertyinterior ??
                                                "");
                                  },
                                  checkColor: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  filterController
                                          .filterToolsDataModel
                                          .propertyInterior?[index]
                                          .propertyinterior
                                          .toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          fontSize: 12.0, color: textColor3),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.mainFilter,
                  arguments:
                      PassFilterModel(id: 6, logLate: "", title: "Main Filter"),
                );
              },
              child: Container(
                height: kBottomNavigationBarHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "See all Properties",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: buttonTextColor),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget customPopupItemBuilder(BuildContext context, item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item,
          style: Theme.of(context).textTheme.labelSmall, // Small font size
        ),
      ),
    );
  }
}
