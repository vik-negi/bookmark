import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        // PageViewModel(
        //   title: "Looking for a new book to read?",
        //   body:
        //       "We have wide range of books with different genres, you can find your favorite book here.",
        //   image: Center(
        //       child: CircleAvatar(
        //     radius: 105,
        //     backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        //     child: Image(
        //       image: AssetImage("assets/images/logo_black.png"),
        //     ),
        //   )),
        //   decoration: PageDecoration(
        //     titleTextStyle:
        //         const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        //     bodyTextStyle:
        //         const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        //     bodyPadding: const EdgeInsets.all(16),
        //     pageColor: Theme.of(context).scaffoldBackgroundColor,
        //     imagePadding: const EdgeInsets.all(0),
        //   ),
        // ),
        PageViewModel(
          title: "",
          // titleWidget: Container(
          //     width: Get.width,
          //     height: 75,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: const [
          //             CircleAvatar(
          //               // backgroundColor: Theme.of(context).cardColor,
          //               child: Icon(Icons.search),
          //             ),
          //             SizedBox(width: 16),
          //             Text(
          //               "Find a book",
          //               style: TextStyle(
          //                   fontSize: 18, fontWeight: FontWeight.w700),
          //             ),
          //           ],
          //         ),
          //         IconButton(
          //             onPressed: () {},
          //             icon: const Icon(Icons.arrow_forward_ios))
          //       ],
          //     )),
          bodyWidget: Column(
            children: [
              Center(
                child: Container(
                    width: Get.width,
                    height: 300,
                    // ignore: prefer_const_constructors
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Image.asset("assets/images/logo_black.png"),
                    )),
              ),
              const SizedBox(height: 45),
              const Text(
                "Looking for a new book to read?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              // const Divider(
              //   thickness: 1,
              // ),
              const Text(
                "We have wide range of books with different genres, you can find your favorite book here.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          decoration: PageDecoration(
            titleTextStyle:
                const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            bodyTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyPadding: const EdgeInsets.all(16),
            pageColor: Theme.of(context).scaffoldBackgroundColor,
            imagePadding: const EdgeInsets.all(0),
          ),
        ),
        PageViewModel(
          // title: "Looking for a new book to read?",
          titleWidget: Container(
              width: Get.width,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        // backgroundColor: Theme.of(context).cardColor,
                        child: Icon(Icons.search),
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Find a book",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              )),
          bodyWidget: Column(
            children: [
              Center(
                  child: Stack(
                children: [
                  Container(
                      width: Get.width,
                      height: 300,
                      // ignore: prefer_const_constructors
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/intro2bg.png"),
                      )),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                        // height: 300,
                        // ignore: prefer_const_constructors
                        child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.red.withAlpha(200),
                      child: const Icon(Icons.check, size: 55),
                    )),
                  )
                ],
              )),
              const SizedBox(height: 45),
              const Text(
                "We will help you find the best book for you",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Divider(
                thickness: 1,
              ),
              const Text(
                "Choose from a wide range of books and genres, and find the best book for you, read it and share it with your friends",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          decoration: PageDecoration(
            titleTextStyle:
                const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            bodyTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyPadding: const EdgeInsets.all(16),
            pageColor: Theme.of(context).scaffoldBackgroundColor,
            imagePadding: const EdgeInsets.all(0),
          ),
        ),
        PageViewModel(
          // title: "Looking for a new book to read?",
          titleWidget: Container(
              width: Get.width,
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // CircleAvatar(
                      //   // backgroundColor: Theme.of(context).cardColor,
                      //   child: Icon(Icons.search),
                      // ),
                      // SizedBox(width: 16),
                      // Text(
                      //   "Bookmark",
                      //   style: TextStyle(
                      //       fontSize: 18, fontWeight: FontWeight.w700),
                      // ),
                      Image.asset("assets/images/logo_black.png",
                          fit: BoxFit.fill, scale: 2),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              )),
          bodyWidget: Column(
            children: [
              Center(
                  child: Stack(
                children: [
                  Container(
                      width: Get.width,
                      height: 300,
                      // ignore: prefer_const_constructors
                      child: CircleAvatar(
                        backgroundColor:
                            AppColors.persianColor.withOpacity(0.6),
                        child: Icon(
                          Icons.search,
                          size: 105,
                        ),
                      )),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                        // height: 300,
                        // ignore: prefer_const_constructors
                        child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.red.withAlpha(200),
                      child: const Icon(Icons.bookmark, size: 45),
                    )),
                  )
                ],
              )),
              const SizedBox(height: 45),
              const Text(
                "Looking for a new book to read?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Divider(
                thickness: 1,
              ),
              const Text(
                "Book your favorite book with Bookmark in just a few clicks, and read it whenever you want",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          decoration: PageDecoration(
            titleTextStyle:
                const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            bodyTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyPadding: const EdgeInsets.all(16),
            pageColor: Theme.of(context).scaffoldBackgroundColor,
            imagePadding: const EdgeInsets.all(0),
          ),
        ),
      ],
      showSkipButton: true,
      showNextButton: false,
      skip: const Text("Skip"),
      done: const Text("Done"),
      onDone: () async {
        await SharedPrefs.setBool("newDevice", false);
        // On button pressed
        Get.to(() => HomeView());
      },
    );
  }
}
