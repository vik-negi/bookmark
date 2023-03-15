import 'package:bookmark/ui/add_book/add_book.dart';
import 'package:bookmark/ui/add_book/user_added_books.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/main/order_page.dart';
import 'package:bookmark/ui/order_page/user_orders_page.dart';
import 'package:bookmark/ui/register/login.dart';
import 'package:bookmark/utils/cupertinoDialogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookmark/ui/aboutus.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:bookmark/ui/profile/profile.dart';
import 'package:bookmark/ui/profile/setting_Screen.dart';
import 'package:get/get.dart';
import 'package:bookmark/utils/shared_prefer.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final String imgUrl = "";
  DiningVM vm = Get.isRegistered<DiningVM>() ? Get.find() : Get.put(DiningVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return vm.isUserLoginedIn ? LogInDrwaer() : LogInRequiredDrwaer();
    });
  }
}

class LogInDrwaer extends StatelessWidget {
  const LogInDrwaer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          color: Theme.of(context).scaffoldBackgroundColor,
          // color: Colors.red,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: Get.height - 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DrawerHeader(
                          padding: EdgeInsets.zero,
                          child: UserAccountsDrawerHeader(
                            onDetailsPressed: (() => Get.to(() => FifthPage())),
                            arrowColor: Colors.black87,
                            decoration: BoxDecoration(
                                // color: Color.fromARGB(255, 34, 58, 99),
                                // color: Theme.of(context).backgroundColor,
                                ),
                            margin: EdgeInsets.zero,
                            accountEmail: Text(vm.currentUserData["email"]!,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            accountName: Text(vm.currentUserData["userName"]!,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            currentAccountPicture: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                vm.currentUserData["image"]!,
                                width: 150,
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                        DrawerItems(
                            iconData: Icons.home,
                            title: 'Home',
                            onTapFunc: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomeView()))),
                        DrawerItems(
                            iconData: Icons.add,
                            title: 'Add Book',
                            onTapFunc: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => AddBook()))),
                        DrawerItems(
                            iconData: Icons.book,
                            title: 'My Books',
                            onTapFunc: () {
                              vm.getUserBooks();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => UserAddedBooks()));
                            }),
                        DrawerItems(
                            iconData: Icons.shopping_cart,
                            title: 'My Cart',
                            onTapFunc: () {
                              vm.getUserBookmarked();
                              Get.to(() => OrderPage());
                            }),
                        DrawerItems(
                            iconData: Icons.delivery_dining,
                            title: 'My Orders',
                            onTapFunc: () => Get.to(() => UserOrdersPage())),
                        DrawerItems(
                          iconData: Icons.info_outline_rounded,
                          title: 'About US',
                          onTapFunc: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => AboutUsScreen())),
                        ),
                        DrawerItems(
                          iconData: CupertinoIcons.profile_circled,
                          title: 'Profile',
                          onTapFunc: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => FifthPage())),
                        ),
                        DrawerItems(
                          iconData: CupertinoIcons.settings_solid,
                          title: 'Setting',
                          onTapFunc: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingScreen()));
                          },
                        ),
                        const Divider(height: 5, color: Colors.grey),
                        DrawerItems(
                          iconData: CupertinoIcons.lock,
                          title: 'logout',
                          onTapFunc: () {
                            CupertinoDialogBox(context, () {
                              Navigator.pop(context);
                              vm.logout();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomeView()));
                            }, "Logout", 'Are you sure you want to logout?');
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return Container(
                            //         width: Get.width * 0.8,
                            //         height: 200,
                            //         child: AlertDialog(
                            //           title: Text("Are you sure you want to logout?"),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: () {
                            //                   Navigator.pop(context);
                            //                 },
                            //                 child: Text("No")),
                            //             TextButton(
                            //                 onPressed: () {
                            //                   Navigator.pop(context);
                            //                   vm.logout();

                            //                   Navigator.of(context).pushReplacement(
                            //                       MaterialPageRoute(
                            //                           builder: (context) => HomeView()));
                            //                 },
                            //                 child: Text("Yes")),
                            //           ],
                            //         ),
                            //       );
                            //     });
                            // vm.logout();
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(builder: (context) => HomeView()));
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('version 2.0.0',
                          style: TextStyle(color: Colors.grey.shade500)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class LogInRequiredDrwaer extends StatelessWidget {
  const LogInRequiredDrwaer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Drawer(
        child: Container(
          padding: EdgeInsets.zero,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Container(
                  height: Get.height - 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // DrawerHeader(
                          //   padding: EdgeInsets.zero,
                          //   child: UserAccountsDrawerHeader(
                          //     // onDetailsPressed: (() => Get.to(() => FifthPage())),
                          //     arrowColor: Colors.black87,
                          //     decoration: BoxDecoration(
                          //         // color: Color.fromARGB(255, 34, 58, 99),
                          //         // color: Theme.of(context).backgroundColor,
                          //         ),
                          //     margin: EdgeInsets.zero,
                          //     accountEmail: Text("example@example.com",
                          //         style: TextStyle(color: Theme.of(context).primaryColor)),
                          //     accountName: Text("UserName",
                          //         style: TextStyle(color: Theme.of(context).primaryColor)),
                          //     currentAccountPicture: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50),
                          //       child: Image.network(
                          //         "https://res.cloudinary.com/dczd69z1w/image/upload/v1675174722/default_person_adsn2a.png",
                          //         width: 150,
                          //         fit: BoxFit.cover,
                          //         height: 150,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 30),
                          DrawerItems(
                              iconData: Icons.home,
                              title: 'Home',
                              onTapFunc: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => HomeView()))),
                          DrawerItems(
                            iconData: Icons.info_outline_rounded,
                            title: 'About US',
                            onTapFunc: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => AboutUsScreen())),
                          ),
                          DrawerItems(
                            iconData: CupertinoIcons.settings_solid,
                            title: 'Setting',
                            onTapFunc: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingScreen()));
                            },
                          ),
                          const Divider(height: 5, color: Colors.grey),
                          DrawerItems(
                              iconData: CupertinoIcons.lock,
                              title: 'singin',
                              onTapFunc: () {
                                Get.to(() => LoginPage());
                              })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('version 2.0.0',
                            style: TextStyle(color: Colors.grey.shade500)),
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
    });
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTapFunc,
  }) : super(key: key);
  final String title;
  final IconData iconData;
  final Function? onTapFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTapFunc != null) {
          onTapFunc!();
        }
      },
      child: ListTile(
        leading: Icon(
          iconData,
          color: (title == "logout")
              ? Colors.red
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
        title: Text(
          title,
          textScaleFactor: 1.2,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: (title == "logout")
                ? Colors.red
                : Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ),
    );
  }
}
