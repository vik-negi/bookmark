import 'dart:io';

import 'package:bookmark/constants/textstyles.dart';
import 'package:bookmark/model/book.dart';
import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/ui/add_book/user_book_des.dart';
import 'package:bookmark/ui/animation/fade_animation.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/book_details_page/new_details.dart';
import 'package:bookmark/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserAddedBooks extends StatefulWidget {
  const UserAddedBooks({super.key});

  @override
  State<UserAddedBooks> createState() => _UserAddedBooksState();
}

class _UserAddedBooksState extends State<UserAddedBooks> {
  DiningVM vm = Get.put(DiningVM());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
          appBar: AppBar(
            title: Text('User Added Books'),
          ),
          drawer: MyDrawer(),
          body: vm.loader
              ? CircularProgressIndicator()
              : vm.errorOccurUserBook
                  ? Center(child: Text("Something went wrong"))
                  : vm.userBook.isEmpty
                      ? Center(
                          child: Container(
                            height: Get.height,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.grey.shade400,
                                    size: 75,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("You haven't add any book",
                                      style: TextStyle(fontSize: 18)),
                                  const SizedBox(height: 75),
                                ],
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: i == 0 ? 30 : 10),
                              // margin: const EdgeInsets.symmetric(
                              //     horizontal: 10, vertical: 30),
                              child: UserBooksWidgets(
                                userbook: vm.userBook[i],
                              ),
                            );
                          },
                          separatorBuilder: (context, i) {
                            return SizedBox(width: 10);
                          },
                          itemCount: vm.userBook.length,
                        ));
    });
  }
}

class UserBooksWidgets extends StatelessWidget {
  BookModel userbook;
  UserBooksWidgets({Key? key, required this.userbook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return FadeAnimation(
        1.4,
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Row(children: [
              Container(
                height: 200,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(userbook.image1.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: Get.width - 180,
                height: 200,
                child: InkWell(
                  onTap: () {
                    Get.to(() => UserBookDetails(bookModel: userbook));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width > 400 ? 200 : Get.width - 180,
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: userbook.bookName,
                                  style: TextStyles.blueTitle),
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            maxLines: 3,
                            text: TextSpan(
                                text: userbook.description ??
                                    "this book is one of the best selling book in 2020",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            RichText(
                                text: TextSpan(
                                    text:
                                        "₹ ${(userbook.rentPerDay!).toStringAsFixed(2)}",
                                    style: TextStyles.blueTitle,
                                    children: const [
                                  TextSpan(
                                      text: " Per day",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ))
                                ])),
                            // const SizedBox(width: 10),
                            // const Text('2 days ago')
                          ]),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 45,
                        width: Get.width > 400 ? 200 : Get.width - 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade900,
                        ),
                        child: const Center(
                          child: Text("View Details",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ])),
      );
    });
  }
}
