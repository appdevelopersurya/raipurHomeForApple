import 'package:flutter/material.dart';
import 'package:fmraipuromes/app/routes/routes.dart';
import 'package:fmraipuromes/constant/color.dart';
import 'package:fmraipuromes/helper/GetStorageHelper.dart';
import 'package:gap/gap.dart';

import '../../../utils/DotIndicator.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> Pages = [
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/onBoardImage1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/onBoardImage4.jpg"),
            fit: BoxFit.cover),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/onBoardImage3.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
                print("Current index: $_currentIndex");
              },
              controller: _pageController,
              children: Pages,
            )),
        Positioned(
            bottom: 50,
            right: 20,
            left: 20,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    textAlign: TextAlign.center,
                    _currentIndex == 0
                        ? "Unlock your dream home with ease. Explore, save, connect"
                        : _currentIndex == 1
                            ? "Discover homes that match your style and budget. Save your favorites, and connect with real estate experts."
                            : "Get personalized recommendations and find your perfect home. Connect with professionals to assist you.",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
                Gap(size.height * 0.010),
                Text(
                  textAlign: TextAlign.center,
                  _currentIndex == 0
                      ? "Discover your dream home hassle-free with our intuitive onboarding. Explore listings, save favorites, and connect with experts effortlessly."
                      : _currentIndex == 1
                          ? "Easily navigate through various home listings, save your favorites, and get expert advice."
                          : "Enjoy a seamless experience in finding your ideal home. Connect directly with agents for more details.",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: hintColor, fontSize: 12.0),
                ),
                Gap(size.height * 0.020),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      Pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: DotIndicator(
                          isActive: index == _currentIndex,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(size.height * 0.020),
                InkWell(
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    if (_currentIndex == 2) {
                      Navigator.pushNamed(context, AppRoutes.loginNumber);
                    }
                  },
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: secondaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_currentIndex == 2 ? "Get Started" : "Next",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
