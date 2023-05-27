import 'package:bookmark/constants/textstyles.dart';
import 'package:bookmark/model/book.dart';
import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/ui/add_book/user_book_des.dart';
import 'package:bookmark/ui/animation/fade_animation.dart';
import 'package:bookmark/ui/book_details_page/new_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:get/get.dart';

class LikedFoodSceen extends StatelessWidget {
  const LikedFoodSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
          appBar: AppBar(
            // backgroundColor: AppColors.whiteColor,
            // foregroundColor: AppColors.blackColor,
            title: const Text("Liked Items"),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  vm.deleteMultipleLiked = false;
                  vm.removeLikedBookList.clear();
                  for (var element in vm.removeLikedBookList) {
                    element.checkValue = false;
                    vm.update();
                  }
                  vm.update();
                  Get.back();
                }),
            actions: [
              IconButton(
                onPressed: () {
                  vm.deleteMultipleLiked = !vm.deleteMultipleLiked;
                  vm.update();
                },
                icon: Icon(
                  vm.deleteMultipleLiked ? CupertinoIcons.trash : Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
          body: vm.likedBookList.isNotEmpty
              ? ListView.separated(
                  itemCount: vm.likedBookList.length,
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 15);
                  },
                  itemBuilder: (context, i) {
                    return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return DraggableScrollableSheet(
                                    maxChildSize: 0.25,
                                    expand: false,
                                    minChildSize: 0.2,
                                    initialChildSize: 0.2,
                                    builder: (BuildContext context,
                                        ScrollController scrollController) {
                                      return Container(
                                          padding: const EdgeInsets.all(50),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                AppColors.whiteColor,
                                            child: IconButton(
                                              onPressed: () {
                                                vm.removeLikeItem(
                                                    vm.likedBookList[i]);
                                                // vm.likedBookList
                                                //     .remove(vm.likedBookList[i]);
                                                // vm.update();
                                                Get.back();
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red, size: 35),
                                            ),
                                          ));
                                    });
                              });
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return Container(
                          //           child: IconButton(
                          //         onPressed: () {},
                          //         icon: Icon(Icons.delete, color: Colors.red),
                          //       ));
                          //     });
                        },
                        child: Stack(
                          children: [
                            // CustomFoodCard(i: i, isLikedPage: true),
                            BooksWidgets(userbook: vm.likedBookList[i]),
                            vm.deleteMultipleLiked
                                ? Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Transform.scale(
                                      scale: 1.7,
                                      child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        side: const BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                        activeColor: Colors.white70,
                                        checkColor: Colors.red,
                                        value: vm.likedBookList[i].checkValue,
                                        onChanged: (value) {
                                          vm.likedBookList[i].checkValue =
                                              value!;
                                          if (value != null && value) {
                                            vm.removeLikedBookList
                                                .add(vm.likedBookList[i]);
                                          } else {
                                            vm.removeLikedBookList
                                                .remove(vm.likedBookList[i]);
                                          }
                                          vm.update();
                                        },
                                      ),
                                    ))
                                : const SizedBox(),
                          ],
                        ));
                  })
              : Container(
                  height: Get.height,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.grey.shade400,
                          size: 75,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("You haven't like item",
                            style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                ),
          // bottomNavigationBar: vm.deleteMultipleLiked
          bottomNavigationBar: vm.deleteMultipleLiked
              ? Container(
                  height: 70,
                  width: Get.width,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (vm.removeLikedBookList.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text("Please Select item first",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    )),
                              );
                            });
                      }
                      vm.removeLikedFood();
                      vm.deleteMultipleLiked = false;
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: vm.removeLikedBookList.isEmpty
                                ? Colors.red.shade200
                                : Colors.red.shade400,
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 5),
                        // padding:
                        //     const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignment: Alignment.center,
                        child: const Text(
                          "Delete Selected",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70),
                        )),
                  ))
              : const SizedBox());
    });
  }
}

class BooksWidgets extends StatelessWidget {
  BookModel userbook;
  BooksWidgets({Key? key, required this.userbook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Container(
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
                  Get.to(() => BookDetails(bookModel: userbook));
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
          ]));
    });
  }
}
