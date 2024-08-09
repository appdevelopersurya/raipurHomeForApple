import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/data/modal/FilterToolsDataModel.dart';
import 'package:fmraipuromes/data/modal/PropertySubTypeDataModel.dart';
import 'package:fmraipuromes/data/modal/menuItem.dart';
import 'package:fmraipuromes/data/modal/postPropertyResponseModel.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/getImageFromUser.dart';
import 'package:fmraipuromes/screens/SubPages/PostProperty/viewModel/postPropertyViewModel.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/CustomTextInput.dart';
import 'package:fmraipuromes/utils/HomeTitlesHeading.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:fmraipuromes/utils/futureLoaderNew.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostProperty extends StatefulWidget {
  const PostProperty({super.key});

  @override
  State<PostProperty> createState() => _PostPropertyState();
}

class _PostPropertyState extends State<PostProperty> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  _fetchToolData() {
    final postPropertyController =
        Provider.of<PostPropertyViewModel>(context, listen: false);
    if (mounted) {
      postPropertyController.fetchFilterTools();
    }
  }

  @override
  void initState() {
    _fetchToolData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final postPropertyController = Provider.of<PostPropertyViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        final imageController = context.read<GetImageFromUser>();
        _nameController.clear();
        _addressController.clear();
        _descriptionController.clear();
        postPropertyController.clearFunction();
        Navigator.pop(context);
        imageController.removeImage();
        return false;
      },
      child: Scaffold(
        appBar: const NormalAppBar(title: "Post Property"),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 20),
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              "Basic Info",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: textColor3),
            ),
            const SubPageTitlesHeading3(
              title: "Property Title",
              mandatory: true,
            ),
            const Gap(10.0),
            CustomTextInput2(
                controller: _titleController,
                hintText: "Enter your property title",
                keyboardType: TextInputType.name,
                readOnly: false),
            const Gap(10.0),
            const SubPageTitlesHeading3(title: "Description", mandatory: true),
            const Gap(10.0),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  border: Border.all(width: 1, color: borderColor)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextFormField(
                  autofocus: false,
                  controller: _descriptionController,
                  keyboardType: TextInputType.streetAddress,
                  minLines: 1,
                  maxLines: 15,
                  maxLength: 200,
                  decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: "Write description for your property"),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            const Gap(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubPageTitlesHeading3(
                        title: "Category", mandatory: true),
                    const Gap(10.0),
                    DropdownSearch<MenuItem>(
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem?.label ?? "Select Category",
                          style: Theme.of(context).textTheme.labelSmall,
                        );
                      },
                      items: categoryList,
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Text(
                              item.label ?? "",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        },
                        fit: FlexFit.loose,
                      ),
                      onChanged: (MenuItem? data) {
                        postPropertyController.onCategorySelected(data!);
                        print(
                            "selected cat===> ${postPropertyController.selectedCategory?.label}");
                      },
                      itemAsString: (MenuItem item) {
                        return item.label ?? "";
                      },
                      selectedItem: postPropertyController.selectedCategory,
                    ),
                  ],
                )),
                const Gap(10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubPageTitlesHeading3(
                          title: "Property Type", mandatory: true),
                      const Gap(10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownSearch<Type>(
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              selectedItem?.name ?? "Select Property Type",
                              style: Theme.of(context).textTheme.labelSmall,
                            );
                          },
                          items: postPropertyController.pType,
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Text(
                                  item.name ?? "",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            },
                            fit: FlexFit.loose,
                          ),
                          onChanged: (Type? data) {
                            postPropertyController.onSelectTypes(data!);
                            var body = {
                              "property_type":
                                  "${postPropertyController.selectType?.id}"
                            };
                            postPropertyController.fetchDependencyTools(body);
                            print(
                                "selected p type===> ${postPropertyController.selectType?.id}");
                          },
                          itemAsString: (Type item) {
                            return item.name ?? "";
                          },
                          selectedItem: postPropertyController.selectType,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10.0),
            const SubPageTitlesHeading3(
                title: "Property Sub Type", mandatory: true),
            const Gap(10.0),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              child: DropdownSearch<Data1>(
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem?.name ?? "Select Property Sub Type",
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                },
                items: postPropertyController.pSubType,
                popupProps: PopupProps.menu(
                  itemBuilder: (context, item, isSelected) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: Text(
                        item.name ?? "",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    );
                  },
                  fit: FlexFit.loose,
                ),
                onChanged: (Data1? data) {
                  postPropertyController.onpTypeSelected(data!);
                  print(postPropertyController.selectedPType?.name);
                },
                itemAsString: (Data1 item) {
                  return item.name ?? "";
                },
                selectedItem: postPropertyController.selectedPType,
              ),
            ),
            const Gap(10.0),
            const SubPageTitlesHeading3(title: "Address", mandatory: true),
            const Gap(10.0),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  border: Border.all(width: 1, color: borderColor)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  minLines: 1,
                  maxLines: 15,
                  maxLength: 200,
                  decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: "Property Address"),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            const Gap(10.0),
            Text(
              "Gallery",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: textColor3),
            ),
            const Gap(10.0),
            const SubPageTitlesHeading3(
                title: "Upload Property Image", mandatory: true),
            const Gap(10.0),
            Consumer<GetImageFromUser>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16.0))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: Text(
                                  'Gallery',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                onTap: () {
                                  value.pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: Text(
                                  'Camera',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                onTap: () {
                                  value.takePhoto();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 400,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: borderColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: value.image == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/png/add_photo.png",
                                  height: 100,
                                  width: 100,
                                ),
                                const Gap(10.0),
                                const Text("Tap to select image"),
                              ],
                            ),
                          )
                        : value.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  value.image ?? value.image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Text('No image selected.'),
                  ),
                );
              },
            ),
            // const Gap(10.0),
            // Text(
            //   "Personal Info:",
            //   style: Theme.of(context)
            //       .textTheme
            //       .labelLarge!
            //       .copyWith(color: textColor3),
            // ),
            // const Gap(10.0),
            // Row(
            //   children: [
            //     Expanded(
            //         child: Column(
            //       children: [
            //         const SubPageTitlesHeading3(title: "Name"),
            //         CustomTextInput2(
            //             controller: _nameController,
            //             hintText: "Enter your name",
            //             keyboardType: TextInputType.name,
            //             readOnly: false),
            //       ],
            //     )),
            //     const Gap(10),
            //     Expanded(
            //         child: Column(
            //       children: [
            //         const SubPageTitlesHeading3(title: "Email"),
            //         CustomTextInput2(
            //             controller: _emailController,
            //             hintText: "Enter your email",
            //             keyboardType: TextInputType.emailAddress,
            //             readOnly: false),
            //       ],
            //     )),
            //   ],
            // ),
            // const Gap(10.0),
            // const SubPageTitlesHeading3(title: "Phone"),
            // Container(
            //     alignment: Alignment.centerLeft,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       border: Border.all(width: 1, color: borderColor),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: TextFormField(
            //         controller: _phoneController,
            //         keyboardType: TextInputType.number,
            //         textAlign: TextAlign.left,
            //         style: Theme.of(context).textTheme.labelSmall,
            //         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //         maxLength: 10,
            //         decoration: InputDecoration(
            //           counterText: "",
            //           border: InputBorder.none,
            //           hintText: "Enter your mobile number",
            //           hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
            //                 color: hintColor,
            //               ),
            //         ),
            //       ),
            //     )),
            const Gap(20.0),
            CustomButton(
              title: "Post",
              onTap: () {
                final imageController = context.read<GetImageFromUser>();
                if (_titleController.text.isEmpty ||
                    _descriptionController.text.isEmpty ||
                    postPropertyController.selectedCategory?.label == null ||
                    postPropertyController.selectedPType?.name == null ||
                    postPropertyController.selectType?.name == null ||
                    imageController.image == null ||
                    _addressController.text.isEmpty) {
                  Utils.toastMessage(
                      "Please fill all required filled", warningColor);
                } else {
                  Map<String, String> body = {
                    "user_id": '${box.read("cust_id_raipurHomes")}',
                    "title": _titleController.text.toString() ?? "",
                    "description": _descriptionController.text.toString() ?? "",
                    "categories": postPropertyController.selectedCategory?.label
                            .toString() ??
                        "",
                    "property_type":
                        postPropertyController.selectedPType?.id.toString() ??
                            "",
                    "type":
                        postPropertyController.selectType?.id.toString() ?? "",
                    "address": _addressController.text.toString() ?? "",
                  };
                  print("post body ====> $body");
                  customFutureLoader(
                    context: context,
                    future: () {
                      return postPropertyController.postPropertyApi(
                        false,
                        body,
                        "property_image",
                        imageController.image?.path.toString() ?? "",
                      );
                    },
                  ).then(
                    (value) {
                      PostPropertyResponseModel postPropertyModel =
                          value.asValue?.value ?? PostPropertyResponseModel();
                      if (postPropertyModel.success == true) {
                        Utils.toastMessage(
                            "Your property has posted", successColor);
                        _nameController.clear();
                        _addressController.clear();
                        _descriptionController.clear();
                        postPropertyController.clearFunction();
                        Navigator.pop(context);
                        imageController.removeImage();
                      } else {
                        Utils.toastMessage(
                            "Not submitting your post", warningColor);
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<MenuItem> categoryList = [
    MenuItem(id: 0, label: 'Select Category', icon: Icons.local_hospital),
    MenuItem(id: 1, label: 'For Rent', icon: Icons.local_hospital),
    MenuItem(id: 2, label: 'For Sell', icon: Icons.computer),
  ];

  List<MenuItem> propertyType = [
    MenuItem(id: 0, label: 'Select P Type', icon: Icons.local_hospital),
    MenuItem(id: 1, label: 'Office', icon: Icons.local_hospital),
    MenuItem(id: 2, label: 'Plot', icon: Icons.computer),
    MenuItem(id: 3, label: 'House', icon: Icons.computer),
  ];

  List<MenuItem> type = [
    MenuItem(id: 0, label: 'Select type', icon: Icons.local_hospital),
    MenuItem(id: 1, label: 'Residential', icon: Icons.local_hospital),
    MenuItem(id: 2, label: 'Commercial', icon: Icons.computer),
    MenuItem(id: 3, label: 'Agriculture', icon: Icons.computer),
    MenuItem(id: 4, label: 'Industrial', icon: Icons.computer),
  ];
}
