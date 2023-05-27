import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:bookmark/ui/profile/address/user_address.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:bookmark/utils/cupertinoDialogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/constants/textstyles.dart';
import 'package:bookmark/ui/profile/liked_food_screen.dart';
import 'package:bookmark/ui/profile/profile_update_screen.dart';
import 'package:bookmark/ui/profile/setting_Screen.dart';
import 'package:bookmark/widgets/my_drawer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FifthPage extends StatefulWidget {
  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  @override
  DiningVM vm = Get.isRegistered<DiningVM>() ? Get.find() : Get.put(DiningVM());
  ProfileVM profileVM =
      Get.isRegistered<ProfileVM>() ? Get.find() : Get.put(ProfileVM());
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          // backgroundColor: AppColors.whiteColor,
          // foregroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            'PROFILE',
            style: TextStyle(
              // color: AppColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                // color: Colors.white,
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text("${vm.currentUserData["userName"]}",
                    // title: Text("${vm.currentUserData["name"]}",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      vm.currentUserData["email"] ?? "Email",
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ProfileEditScreen());
                          },
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: AppColors.highlighterPink,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_right,
                          color: AppColors.highlighterPink,
                        )
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Image.memory(
                    Uint8List.fromList(vm.currentUserData["image"]!.codeUnits),
                    height: 50,
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.3),
                        //     spreadRadius: 1,
                        //     blurRadius: 2,
                        //     offset:
                        //         const Offset(0, 0), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircularTwoColorIcon(
                              onTap: () => Get.to(() => const LikedFoodSceen()),
                              icon: CupertinoIcons.heart_fill,
                              text: 'Likes',
                              topColor: Colors.red.withOpacity(0.3),
                              bottomColor: Colors.red.withOpacity(0.7)),
                          CircularTwoColorIcon(
                              onTap: () => Get.to(() => SettingScreen()),
                              icon: Icons.settings,
                              text: 'Settings',
                              topColor: Colors.blue.withOpacity(0.3),
                              bottomColor: Colors.blue.withOpacity(0.7)),
                          CircularTwoColorIcon(
                              icon: Icons.payment,
                              text: 'Payments',
                              topColor: Colors.green.withOpacity(0.3),
                              bottomColor: Colors.green.withOpacity(0.7)),
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(15),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.3),
                          //         spreadRadius: 1,
                          //         blurRadius: 2,
                          //         offset: const Offset(
                          //             0, 0), // changes position of shadow
                          //       ),
                          //     ],
                          //   ),
                          //   child: Center(
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: <Widget>[
                          //         const Icon(Icons.settings),
                          //         const SizedBox(
                          //           height: 5,
                          //         ),
                          //         const Text('Settings')
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(15),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.3),
                          //         spreadRadius: 1,
                          //         blurRadius: 2,
                          //         offset: const Offset(
                          //             0, 0), // changes position of shadow
                          //       ),
                          //     ],
                          //   ),
                          //   child: Center(
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: <Widget>[
                          //         const Icon(Icons.payment),
                          //         const SizedBox(
                          //           height: 5,
                          //         ),
                          //         const Text('Payments')
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      radius: 20,
                      child: const Icon(Icons.star, color: Colors.yellow),
                    ),
                    title: const Text('Your Ratings'),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Orders Details',
                      style: TextStyles.actionTitleBlack,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 20,
                      child: const Icon(
                        Icons.shopping_cart,
                        color: AppColors.blackColor,
                      ),
                    ),
                    title: const Text(
                      'Orders History',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                  // ListTile(
                  //   leading: CircleAvatar(
                  //     backgroundColor: Colors.grey.shade300,
                  //     radius: 20,
                  //     child: const Icon(
                  //       Icons.heat_pump_rounded,
                  //       color: AppColors.blackColor,
                  //     ),
                  //   ),
                  //   title: const Text(
                  //     'Favorite Orders',
                  //     // style: TextStyles.highlighterTwo,
                  //   ),
                  //   trailing: const Icon(Icons.keyboard_arrow_right),
                  // ),
                  ListTile(
                    onTap: () {
                      profileVM.getAddressList();
                      Get.to(() => UserAddress(isPayment: false));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 20,
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.blackColor,
                      ),
                    ),
                    title: const Text(
                      'Address Book',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),

                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 20,
                      child: const Icon(
                        Icons.help_outline,
                        color: AppColors.blackColor,
                      ),
                    ),
                    title: const Text(
                      'Online Ordering Help',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text(
                      'About',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  const ListTile(
                    title: Text(
                      'Send Feedback',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  const ListTile(
                    title: Text(
                      'Report a Safety Emergency',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  const ListTile(
                    title: Text(
                      'Rate us on the Play Store',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    onTap: () {
                      CupertinoDialogBox(context, () {
                        Navigator.pop(context);
                        vm.logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeView()));
                      }, "Logout", 'Are you sure you want to logout?');
                    },
                    title: Text(
                      'Log Out',
                      // style: TextStyles.highlighterTwo,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CircularTwoColorIcon extends StatelessWidget {
  String? text;
  IconData icon;
  Function()? onTap;
  Color? bottomColor;
  Color? iconColor;
  Color? topColor;
  CircularTwoColorIcon({
    required this.icon,
    this.text = "",
    this.bottomColor,
    this.onTap,
    this.topColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 37,
            child: Container(
              height: 37,
              width: 75,
              decoration: BoxDecoration(
                  color: bottomColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
            )),
        Positioned(
            top: 0,
            child: Container(
              height: 38,
              width: 75,
              decoration: BoxDecoration(
                  color: topColor ?? Colors.grey.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
            )),
        InkWell(
          onTap: () {
            onTap!();
          },
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: iconColor ?? Colors.white,
                    size: 28,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(text ?? "")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
