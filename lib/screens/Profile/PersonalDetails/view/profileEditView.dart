import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fmraipuromes/data/modal/getUserDetails.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:fmraipuromes/repository/getImageFromUser.dart';
import 'package:fmraipuromes/screens/Profile/viewModel/profileViewModel.dart';
import 'package:fmraipuromes/services/apis/app_url.dart';
import 'package:fmraipuromes/utils/CustomTextInput.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:fmraipuromes/utils/futureLoaderNew.dart';
import 'package:fmraipuromes/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../constant/color.dart';
import '../../../../utils/CustomButton.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  _firstLoad() async {
    final profileViewController =
        Provider.of<ProfileViewModel>(context, listen: false);
    if (mounted) {
      profileViewController.getUserDetail(false);
      _nameController.text =
          profileViewController.getUserDetails.data?.userName ?? "";
      _mobileController.text =
          profileViewController.getUserDetails.data?.userNumber ?? "";
      _emailController.text =
          profileViewController.getUserDetails.data?.userEmail ?? "";
      _areaController.text =
          profileViewController.getUserDetails.data?.userAddress ?? "";
      _cityController.text =
          profileViewController.getUserDetails.data?.city ?? "";
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final profileViewController = Provider.of<ProfileViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<GetImageFromUser>().removeImage();
        return true;
      },
      child: Scaffold(
        appBar: const NormalAppBar(title: "Edit Profile"),
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  children: [
                    Consumer<GetImageFromUser>(
                      builder: (context, getImageProvider, child) {
                        return Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 54,
                                backgroundColor: Colors.black,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: getImageProvider.image != null
                                      ? CircleAvatar(
                                          backgroundImage: FileImage(
                                              getImageProvider.image!),
                                          radius: 52,
                                        )
                                      : (profileViewController.getUserDetails
                                                  .data?.userImage !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl: AppUrl.baseUrl +
                                                  profileViewController
                                                      .getUserDetails
                                                      .data!
                                                      .userImage!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                backgroundImage: imageProvider,
                                                radius: 52,
                                              ),
                                              placeholder: (context, url) =>
                                                  const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/icons/contact.png"),
                                                radius: 52,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/icons/contact.png"),
                                                radius: 52,
                                              ),
                                            )
                                          : const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/icons/contact.png"),
                                              radius: 52,
                                            )),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: secondaryColor,
                                    child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(16),
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0))),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.photo_library),
                                                      title: Text(
                                                        'Gallery',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium,
                                                      ),
                                                      onTap: () {
                                                        getImageProvider
                                                            .pickImage(
                                                                ImageSource
                                                                    .gallery)
                                                            .then(
                                                          (value) {
                                                            if (value != null) {
                                                              var body = {
                                                                "userid":
                                                                    '${box.read("cust_id_raipurHomes")}'
                                                              };
                                                              print(
                                                                  "body======> $body");
                                                              customFutureLoader(
                                                                  context:
                                                                      context,
                                                                  future: () async => await profileViewController.updateUserPhoto(
                                                                      false,
                                                                      body,
                                                                      "user_image",
                                                                      value.path ??
                                                                          "")).then(
                                                                (value) {
                                                                  GetUserDetails
                                                                      getUserDetails =
                                                                      value.asValue
                                                                              ?.value ??
                                                                          GetUserDetails();
                                                                  if (getUserDetails
                                                                          .success ==
                                                                      true) {
                                                                    Utils.snackBar(
                                                                        "Successfully Updated",
                                                                        context,
                                                                        successColor);
                                                                    _firstLoad();
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    Utils.snackBar(
                                                                        "Invalid Input",
                                                                        context,
                                                                        errorColor);
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.camera_alt),
                                                      title: Text(
                                                        'Camera',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium,
                                                      ),
                                                      onTap: () {
                                                        final imageController =
                                                            context.read<
                                                                GetImageFromUser>();
                                                        getImageProvider
                                                            .takePhoto()
                                                            .then(
                                                          (value) {
                                                            if (value != null) {
                                                              var body = {
                                                                "userid":
                                                                    '${box.read("cust_id_raipurHomes")}'
                                                              };
                                                              print(
                                                                  "body======> $body");
                                                              customFutureLoader(
                                                                context:
                                                                    context,
                                                                future:
                                                                    () async {
                                                                  return profileViewController
                                                                      .updateUserPhoto(
                                                                    false,
                                                                    body,
                                                                    "user_image",
                                                                    imageController
                                                                            .image
                                                                            ?.path
                                                                            .toString() ??
                                                                        "",
                                                                  );
                                                                },
                                                              ).then(
                                                                (value) {
                                                                  GetUserDetails
                                                                      getUserDetails =
                                                                      value.asValue
                                                                              ?.value ??
                                                                          GetUserDetails();
                                                                  if (getUserDetails
                                                                          .success ==
                                                                      true) {
                                                                    Utils.snackBar(
                                                                        "Successfully Updated",
                                                                        context,
                                                                        successColor);
                                                                    _firstLoad();
                                                                    Navigator.pop(
                                                                        context);
                                                                  } else {
                                                                    Utils.snackBar(
                                                                        "Invalid Input",
                                                                        context,
                                                                        errorColor);
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                },
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 15,
                                          color: Colors.white,
                                        )),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextInput(
                          controller: _nameController,
                          hintText: "Enter your name",
                          keyboardType: TextInputType.name,
                          icon: Icons.person,
                          readOnly: false),
                      Gap(size.height * 0.020),
                      CustomTextInput(
                          controller: _emailController,
                          hintText: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                          readOnly: false),
                      Gap(size.height * 0.020),
                      CustomTextInput(
                          controller: _mobileController,
                          hintText: "Enter your mobile number",
                          keyboardType: TextInputType.number,
                          icon: Icons.call,
                          readOnly: true),
                      Gap(size.height * 0.020),
                      CustomTextInput(
                          controller: _cityController,
                          hintText: "Enter your city",
                          keyboardType: TextInputType.text,
                          icon: Icons.location_city,
                          readOnly: false),
                      Gap(size.height * 0.020),
                      CustomTextInput(
                          controller: _areaController,
                          hintText: "Enter your complete address",
                          keyboardType: TextInputType.streetAddress,
                          icon: Icons.location_history_rounded,
                          readOnly: false),
                      Gap(size.height * 0.020),
                      // Container(
                      //     alignment: Alignment.centerLeft,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(width: 1, color: borderColor),
                      //       borderRadius: BorderRadius.circular(12.0),
                      //     ),
                      //     child: TextFormField(
                      //       controller: _ageController,
                      //       keyboardType: TextInputType.number,
                      //       textAlign: TextAlign.left,
                      //       inputFormatters: [
                      //         FilteringTextInputFormatter.digitsOnly
                      //       ],
                      //       maxLength: 2,
                      //       style: Theme.of(context).textTheme.labelSmall,
                      //       decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "Enter your age",
                      //         counterText: "",
                      //         hintStyle: Theme.of(context)
                      //             .textTheme
                      //             .labelSmall!
                      //             .copyWith(
                      //               color: hintColor,
                      //             ),
                      //         prefixIcon: const Icon(
                      //           Icons.account_box_rounded,
                      //           size: 20,
                      //         ),
                      //       ),
                      //     )),
                      // Gap(size.height * 0.050),
                      CustomButton(
                        title: "Submit",
                        onTap: () {
                          var body = {
                            "user_name": _nameController.text.toString(),
                            "user_email": _emailController.text.toString(),
                            "user_city": _cityController.text.toString(),
                            "user_address": _areaController.text.toString(),
                            "userid": '${box.read("cust_id_raipurHomes")}'
                          };
                          customFutureLoader(
                              context: context,
                              future: () async =>
                                  await profileViewController.updateUserDetails(
                                    false,
                                    body,
                                  )).then(
                            (value) {
                              GetUserDetails getUserDetails =
                                  value.asValue?.value ?? GetUserDetails();
                              if (getUserDetails.success == true) {
                                Utils.snackBar(
                                    getUserDetails.message.toString(),
                                    context,
                                    successColor);
                                _firstLoad();
                              } else {
                                Utils.snackBar(
                                    getUserDetails.message.toString(),
                                    context,
                                    errorColor);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
