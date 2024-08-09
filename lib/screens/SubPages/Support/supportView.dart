import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fmraipuromes/repository/contactFeatures.dart';
import 'package:fmraipuromes/screens/SubPages/Support/supportViewModel.dart';
import 'package:fmraipuromes/utils/CustomButton.dart';
import 'package:fmraipuromes/utils/NormalAppBar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SupportView extends StatefulWidget {
  const SupportView({super.key});

  @override
  State<SupportView> createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  _firstLoad() async {
    final supportViewController =
        Provider.of<SupportViewModel>(context, listen: false);
    if (mounted) {
      supportViewController.getContactDetails();
    }
  }

  @override
  void initState() {
    _firstLoad();
    super.initState();
  }

  //
  // _launchWhatsapp(BuildContext context) async {
  //   var storeURL = Platform.isIOS
  //       ? "whatsapp://send?phone=$whatsappNumber&text=${Uri.encodeComponent(message)}"
  //       //     ? "https://play.google.com/store/apps"
  //       //     : "https://www.apple.com/in/app-store/";
  //       : "whatsapp://send?phone=$whatsappNumber&text=${Uri.encodeFull(message)}";
  //
  //   if (!await launchUrl(Uri.parse(storeURL))) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Invalid URL"),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Opening WhatsApp"),
  //       ),
  //     );
  //   }
  // }
  //
  // _launchCalling(BuildContext context) async {
  //   var storeURL = Platform.isIOS
  //       ? 'tel:+91 $callNumber'
  //       //     ? "https://play.google.com/store/apps"
  //       //     : "https://www.apple.com/in/app-store/";
  //       : 'tel:+91 $callNumber';
  //
  //   if (!await launchUrl(Uri.parse(storeURL))) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Invalid URL"),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Calling..."),
  //       ),
  //     );
  //   }
  // }
  //
  // _launchEmail(BuildContext context) async {
  //   String email = 'raipurhomes8@gmail.com';
  //   String title = 'The subject';
  //   String message = '';
  //
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     query: 'subject=$title&body=$message',
  //   );
  //   var url = params.toString();
  //   if (!await launchUrl(Uri.parse(url))) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Invalid URL"),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Opening Mail..."),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final supportViewController = Provider.of<SupportViewModel>(context);
    return Scaffold(
        appBar: const NormalAppBar(title: "Support"),
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: FadeInDown(
                child: Container(
                  alignment: Alignment.center,
                  child: Lottie.asset('assets/gif/support.json', animate: true),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInLeft(
                          child: CustomButton3(
                            onTap: () => ContactFeatures().launchWhatsapp(
                                context,
                                supportViewController.contactUsDataModel.data
                                        ?.adminWhatsappNumber
                                        .toString()
                                        .trim() ??
                                    "",
                                "Hello, I am considering purchasing a property in the downtown area and would appreciate any additional information you can provide about this location."),
                            title: "Contact Via WhatsApp",
                            leading: SvgPicture.asset(
                              "assets/svg/whataspp.svg",
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInRight(
                          child: CustomButton3(
                            onTap: () => ContactFeatures().launchCalling(
                                context,
                                supportViewController
                                        .contactUsDataModel.data?.adminNumber
                                        .toString()
                                        .trim() ??
                                    ""),
                            title: "Contact Via Call",
                            leading: Image.asset(
                              "assets/icons/call.png",
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 14.0),
                        child: FadeInLeft(
                          child: CustomButton3(
                            onTap: () => ContactFeatures().launchEmail(
                                context,
                                supportViewController
                                        .contactUsDataModel.data?.adminEmail
                                        .toString()
                                        .trim() ??
                                    ""),
                            title: "Contact Via Mail",
                            leading: SvgPicture.asset(
                              "assets/svg/mail.svg",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
