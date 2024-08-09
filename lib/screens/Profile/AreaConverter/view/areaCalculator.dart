import 'package:animate_do/animate_do.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:gap/gap.dart';

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  String convertValue(
      String inputValue, String initialUnit, String targetUnit) {
    // Parse the input value as a double
    double value = double.tryParse(inputValue)!.roundToDouble() ?? 0.0;

    // Perform unit conversion based on the initial and target units
    switch ('$initialUnit-$targetUnit') {
      // Square Feet conversions
      case "Sq. ft-Sq. ft":
        return value.toString(); // Square feet to square feet
      case "Sq. ft-Sq. m":
        return (value * 0.092903).toString(); // Square feet to square meters
      case "Sq. ft-Acre":
        return (value / 43560).toString(); // Square feet to acres
      case "Sq. ft-Hectare":
        return (value / 107639).toString(); // Square feet to hectares
      case "Sq. ft-Gaj":
        return (value * 0.111111).toString(); // Square feet to gaj
      case "Sq. ft-Bigha":
        return (value / 67725).toString(); // Square feet to Bigha
      case "Sq. ft-Cent":
        return (value / 435.6).toString(); // Square feet to cent
      case "Sq. ft-Katha":
        return (value / 1361.25).toString(); // Square feet to katha
      case "Sq. ft-Guntha":
        return (value / 10890).toString(); // Square feet to guntha

      // Square Meters conversions
      case "Sq. m-Sq. m":
        return value.toString();
      case "Sq. m-Sq. ft":
        return (value * 10.7639).toString(); // Square meters to square feet
      case "Sq. m-Acre":
        return (value / 4047).toString(); // Square meters to acres
      case "Sq. m-Hectare":
        return (value / 10000).toString(); // Square meters to hectares
      case "Sq. m-Gaj":
        return (value * 0.098847).toString(); // Square meters to gaj
      case "Sq. m-Bigha":
        return (value / 628.828).toString(); // Square meters to Bigha
      case "Sq. m-Cent":
        return (value / 40.4686).toString(); // Square meters to cent
      case "Sq. m-Katha":
        return (value / 126.077).toString(); // Square meters to katha
      case "Sq. m-Guntha":
        return (value / 1008).toString(); // Square meters to guntha

      // Acres conversions
      case "Acre-Acre":
        return value.toString();
      case "Acre-Sq. ft":
        return (value * 43560).toString(); // Acres to square feet
      case "Acre-Sq. m":
        return (value * 4047).toString(); // Acres to square meters
      case "Acre-Hectare":
        return (value * 0.404686).toString(); // Acres to hectares
      case "Acre-Gaj":
        return (value * 4840).toString(); // Acres to gaj
      case "Acre-Bigha":
        return (value * 6.05).toString(); // Acres to Bigha
      case "Acre-Cent":
        return (value * 100).toString(); // Acres to cent
      case "Acre-Katha":
        return (value * 3.08).toString(); // Acres to katha
      case "Acre-Guntha":
        return (value * 24.71).toString(); // Acres to guntha

      // Hectares conversions
      case "Hectare-Hectare":
        return value.toString();
      case "Hectare-Sq. ft":
        return (value * 107639).toString(); // Hectares to square feet
      case "Hectare-Sq. m":
        return (value * 10000).toString(); // Hectares to square meters
      case "Hectare-Acre":
        return (value * 2.47105).toString(); // Hectares to acres
      case "Hectare-Gaj":
        return (value * 11959.9).toString(); // Hectares to gaj
      case "Hectare-Bigha":
        return (value * 15).toString(); // Hectares to Bigha
      case "Hectare-Cent":
        return (value * 247.105).toString(); // Hectares to cent
      case "Hectare-Katha":
        return (value * 7.63).toString(); // Hectares to katha
      case "Hectare-Guntha":
        return (value * 63.58).toString(); // Hectares to guntha

      // Gaj conversions
      case "Gaj-Gaj":
        return value.toString();
      case "Gaj-Sq. ft":
        return (value * 9).toString(); // Gaj to square feet
      case "Gaj-Sq. m":
        return (value * 0.101171).toString(); // Gaj to square meters
      case "Gaj-Acre":
        return (value * 0.000206612).toString(); // Gaj to acres
      case "Gaj-Hectare":
        return (value * 0.0000836124).toString(); // Gaj to hectares
      case "Gaj-Bigha":
        return (value * 0.000125).toString(); // Gaj to Bigha
      case "Gaj-Cent":
        return (value * 0.00258381).toString(); // Gaj to cent
      case "Gaj-Katha":
        return (value * 0.0000795716).toString(); // Gaj to katha
      case "Gaj-Guntha":
        return (value * 0.000661157).toString(); // Gaj to guntha

      // Bigha conversions
      case "Bigha-Bigha":
        return value.toString();
      case "Bigha-Sq. ft":
        return (value * 17545).toString(); // Bigha to square feet
      case "Bigha-Sq. m":
        return (value * 1641.59).toString(); // Bigha to square meters
      case "Bigha-Acre":
        return (value * 0.165).toString(); // Bigha to acres
      case "Bigha-Hectare":
        return (value * 0.0667151).toString(); // Bigha to hectares
      case "Bigha-Gaj":
        return (value * 8000).toString(); // Bigha to gaj
      case "Bigha-Cent":
        return (value * 16.4711).toString(); // Bigha to cent
      case "Bigha-Katha":
        return (value * 0.505856).toString(); // Bigha to katha
      case "Bigha-Guntha":
        return (value * 4.21344).toString(); // Bigha to guntha

      // Cent conversions
      case "Cent-Cent":
        return value.toString();
      case "Cent-Sq. ft":
        return (value * 435.6).toString(); // Cent to square feet
      case "Cent-Sq. m":
        return (value * 40.4686).toString(); // Cent to square meters
      case "Cent-Acre":
        return (value * 0.01).toString(); // Cent to acres
      case "Cent-Hectare":
        return (value * 0.00404686).toString(); // Cent to hectares
      case "Cent-Gaj":
        return (value * 121).toString(); // Cent to gaj
      case "Cent-Bigha":
        return (value * 0.060576).toString(); // Cent to Bigha
      case "Cent-Katha":
        return (value * 0.0308556).toString(); // Cent to katha
      case "Cent-Guntha":
        return (value * 0.253166).toString(); // Cent to guntha

      // Katha conversions
      case "Katha-Katha":
        return value.toString();
      case "Katha-Sq. ft":
        return (value * 1361.25).toString(); // Katha to square feet
      case "Katha-Sq. m":
        return (value * 126.077).toString(); // Katha to square meters
      case "Katha-Acre":
        return (value * 0.324717).toString(); // Katha to acres
      case "Katha-Hectare":
        return (value * 0.130896).toString(); // Katha to hectares
      case "Katha-Gaj":
        return (value * 1566.67).toString(); // Katha to gaj
      case "Katha-Bigha":
        return (value * 1.23457).toString(); // Katha to Bigha
      case "Katha-Cent":
        return (value * 32.25).toString(); // Katha to cent
      case "Katha-Guntha":
        return (value * 8.33333).toString(); // Katha to guntha

      // Guntha conversions
      case "Guntha-Guntha":
        return value.toString();
      case "Guntha-Sq. ft":
        return (value * 10890).toString(); // Guntha to square feet
      case "Guntha-Sq. m":
        return (value * 1008).toString(); // Guntha to square meters
      case "Guntha-Acre":
        return (value * 0.040469).toString(); // Guntha to acres
      case "Guntha-Hectare":
        return (value * 0.0163871).toString(); // Guntha to hectares
      case "Guntha-Gaj":
        return (value * 200).toString(); // Guntha to gaj
      case "Guntha-Bigha":
        return (value * 0.237137).toString(); // Guntha to Bigha
      case "Guntha-Cent":
        return (value * 3.95257).toString(); // Guntha to cent
      case "Guntha-Katha":
        return (value * 0.12).toString(); // Guntha to katha

      default:
        return "Invalid unit combination"; // Return an error message for unsupported combinations
    }
  }

  String? convertedValue;

  List fromUnit = [
    "Sq. ft",
    "Sq. m",
    "Acre",
    'Hectare',
    'Gaj',
    'Bigha',
    'Cent',
    'Katha',
    'Guntha',
  ];

  String _selectedFromValue = "Sq. ft";
  String _selectedToValue = "Sq. ft";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(title: "AreaCalculator"),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Convert $_selectedFromValue to $_selectedToValue",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    "Enter the value and select desired unit",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 12.0, color: subTitleColor),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FadeInRight(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _fromController,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: Theme.of(context).textTheme.labelSmall,
                        onChanged: (value) {
                          if (_fromController.text == "") {
                            _toController.text = '';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "From",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: hintColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                      ),
                    )),
                    Container(
                      height: 24,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                itemBuilder: (BuildContext context, String item,
                                    bool isSelected) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? textColor3
                                          : Colors
                                              .transparent, // Background color when selected
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: Text(item,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black)),
                                  );
                                },
                                menuProps: MenuProps(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                showSelectedItems: true,
                              ),
                              dropdownBuilder: (context, selectedItem) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _selectedFromValue ?? fromUnit.first,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                );
                              },
                              items: const [
                                "Sq. ft",
                                "Sq. m",
                                "Acre",
                                'Hectare',
                                'Gaj',
                                'Bigha',
                                'Cent',
                                'Katha',
                                'Guntha',
                              ],
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Select From",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: hintColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _selectedFromValue = value!;
                                });
                              },
                              selectedItem: _selectedFromValue,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FadeInLeft(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _toController,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: Theme.of(context).textTheme.labelSmall,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "To",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: hintColor),
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none),
                      ),
                    )),
                    Container(
                      height: 24,
                      width: 1,
                      color: Colors.grey.shade400,
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                itemBuilder: (BuildContext context, String item,
                                    bool isSelected) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? textColor3
                                          : Colors
                                              .transparent, // Background color when selected
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    child: Text(item,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black)),
                                  );
                                },
                                menuProps: MenuProps(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                showSelectedItems: true,
                              ),
                              dropdownBuilder: (context, selectedItem) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _selectedToValue ?? fromUnit.first,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                );
                              },
                              items: const [
                                "Sq. ft",
                                "Sq. m",
                                "Acre",
                                'Hectare',
                                'Gaj',
                                'Bigha',
                                'Cent',
                                'Katha',
                                'Guntha',
                              ],
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Select to",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: hintColor),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _selectedToValue = value!;
                                });
                              },
                              selectedItem: _selectedToValue,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: FadeInUp(
              child: CustomButton(
                title: "Convert",
                onTap: () {
                  _toController.text = convertValue(_fromController.text,
                      _selectedFromValue, _selectedToValue);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
