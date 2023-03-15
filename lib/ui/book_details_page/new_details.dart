import 'package:bookmark/model/book.dart';
import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/payment/payment.dart';
import 'package:blur/blur.dart';
import 'package:bookmark/ui/profile/address/user_address.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:bookmark/ui/register/login.dart';
import 'package:bookmark/utils/login_first_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetails extends StatelessWidget {
  BookModel bookModel;
  BookDetails({Key? key, required this.bookModel}) : super(key: key);
  String description =
      "From New York Times bestselling author Alice Hoffman comes a heartfelt short story about family, independence, and finding your place in the world. Isabel Gibson has all but perfected the art of forgetting. She's a New Yorker now, with nothing left to tie her to Brinkley's Island, Maine. Her parents are gone, the family bookstore is all but bankrupt, and her sister, Sophie, will probably never speak to her again.\nBut when a mysterious letter arrives in her mailbox, Isabel feels herself drawn to the past. After years of fighting for her independence, she dreads the thought of going back to the island. What she finds there may forever alter her path—and change everything she thought she knew about her family, her home, and herself.";
  String des =
      "This is a record of France's results at the FIFA World Cup. France was one of the four European teams that participated at the inaugural World Cup in 1930 and have appeared in 15 FIFA World Cups, tied for the sixth most of any country.";
  DiningVM vm = Get.find();
  ProfileVM profileVM =
      Get.isRegistered<ProfileVM>() ? Get.find() : Get.put(ProfileVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: SizedBox(
                width: Get.width - 100,
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: bookModel.bookName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Get.back())),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(bookModel.image1.url,
                        width: Get.width, height: 315, fit: BoxFit.cover)
                    .blurred(
                  colorOpacity: 0.5,
                  // borderRadius:
                  //     BorderRadius.horizontal(right: Radius.circular(20)),
                  blur: 10,
                  overlay: Container(
                    height: 325,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 20),
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: NetworkImage(widget.bookModel.url!),
                      //   fit: BoxFit.cover,
                      // ),
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withOpacity(0), Colors.white]),
                    ),
                    child: Column(
                      children: [
                        // Container(
                        //   width: Get.width,
                        //   height: 45,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       CircularWidget(
                        //           icon: Icons.arrow_back_ios,
                        //           function: () => Get.back()),
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 15.0),
                        //         child: CircularWidget(
                        //             icon: CupertinoIcons.heart_fill,
                        //             size: 28,
                        //             function: () {},
                        //             color: Colors.red),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 255,
                                width: 175,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    bookModel.image1.url,
                                    height: 255,
                                    width: 175,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: Get.width - 230,
                                  child: RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: bookModel.bookName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: Get.width - 250,
                                  child: RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Owner : Vikram Negi",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "4.5",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "(100)",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      child: CircularWidget(
                                          icon: bookModel.isLiked
                                              ? CupertinoIcons.heart_fill
                                              : Icons.favorite_outline_rounded,
                                          size: 28,
                                          function: () {
                                            if (!vm.isUserLoginedIn) {
                                              LoginFirstDialog(context);
                                              return;
                                            }
                                            bookModel.isLiked =
                                                !bookModel.isLiked;
                                            if (vm.likedBookList
                                                .contains(bookModel)) {
                                              vm.likedBookList
                                                  .remove(bookModel);
                                            } else {
                                              vm.likedBookList.add(bookModel);
                                            }
                                            vm.update();
                                          },
                                          color: Colors.red),
                                      // const SizedBox(width: 20),
                                      // CircularWidget(
                                      //     icon: vm.isBookInCartList(bookModel)
                                      //         ? CupertinoIcons.bookmark_solid
                                      //         : CupertinoIcons.bookmark,
                                      //     size: 28,
                                      //     function: () {
                                      //       vm.addInCartList(bookModel);
                                      //       vm.increaseQuantity(bookModel);
                                      //     },
                                      //     color:
                                      //         vm.isBookInCartList(bookModel)
                                      //             ? Colors.grey.shade900
                                      //             : Colors.grey.shade900)
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        vm.validateAndSaveToCart(bookModel);
                                      },
                                      child: Container(
                                          height: 45,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade900,
                                              borderRadius:
                                                  BorderRadius.circular(26)),
                                          child: Center(
                                            child: Text("Add to Cart",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 325,
                //   width: double.infinity,
                //   padding: const EdgeInsets.symmetric(
                //       vertical: 18.0, horizontal: 20),
                //   decoration: const BoxDecoration(
                //     // image: DecorationImage(
                //     //   image: NetworkImage(widget.bookModel.url!),
                //     //   fit: BoxFit.cover,
                //     // ),
                //     gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [Colors.black, Colors.white]),
                //   ),
                //   child: Column(
                //     children: [
                //       // Container(
                //       //   width: Get.width,
                //       //   height: 45,
                //       //   child: Row(
                //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       //     children: [
                //       //       CircularWidget(
                //       //           icon: Icons.arrow_back_ios,
                //       //           function: () => Get.back()),
                //       //       Padding(
                //       //         padding: const EdgeInsets.only(right: 15.0),
                //       //         child: CircularWidget(
                //       //             icon: CupertinoIcons.heart_fill,
                //       //             size: 28,
                //       //             function: () {},
                //       //             color: Colors.red),
                //       //       )
                //       //     ],
                //       //   ),
                //       // ),
                //       const SizedBox(height: 10),
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //               height: 255,
                //               width: 175,
                //               decoration: const BoxDecoration(
                //                   borderRadius: BorderRadius.all(
                //                 Radius.circular(10),
                //               )),
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(20),
                //                 child: Image.network(
                //                   bookModel.thumbnail!,
                //                   height: 255,
                //                   width: 175,
                //                   fit: BoxFit.cover,
                //                 ),
                //               )),
                //           const SizedBox(
                //             width: 15,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const SizedBox(height: 20),
                //               SizedBox(
                //                 width: Get.width - 230,
                //                 child: RichText(
                //                     maxLines: 4,
                //                     text: TextSpan(
                //                       text: bookModel.title!,
                //                       style: const TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 20,
                //                           fontWeight: FontWeight.bold),
                //                     )),
                //               ),
                //               const SizedBox(
                //                 height: 10,
                //               ),
                //               SizedBox(
                //                 width: Get.width - 250,
                //                 child: const Text(
                //                   "by Vikram Negi",
                //                   style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 10,
                //               ),
                //               Column(
                //                 mainAxisSize: MainAxisSize.max,
                //                 children: [
                //                   Container(
                //                     child: Row(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: const [
                //                         Icon(
                //                           Icons.star,
                //                           color: Colors.yellow,
                //                           size: 20,
                //                         ),
                //                         SizedBox(
                //                           width: 5,
                //                         ),
                //                         Text(
                //                           "4.5",
                //                           style: TextStyle(
                //                               color: Colors.white,
                //                               fontSize: 16,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                         SizedBox(
                //                           width: 5,
                //                         ),
                //                         Text(
                //                           "(100)",
                //                           style: TextStyle(
                //                               color: Colors.white,
                //                               fontSize: 16,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   const SizedBox(height: 20),
                //                   Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       CircularWidget(
                //                           icon: CupertinoIcons.heart_fill,
                //                           size: 28,
                //                           function: () {},
                //                           color: Colors.red),
                //                       const SizedBox(width: 20),
                //                       CircularWidget(
                //                           icon: vm.isBookInCartList(bookModel)
                //                               ? CupertinoIcons.bookmark_solid
                //                               : CupertinoIcons.bookmark,
                //                           size: 28,
                //                           function: () {
                //                             vm.addInCartList(bookModel);
                //                             vm.increaseQuantity(bookModel);
                //                           },
                //                           color: vm.isBookInCartList(bookModel)
                //                               ? Colors.grey.shade900
                //                               : Colors.grey.shade900)
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // Container(
                //     child: Text(
                //   ,
                //   style: const TextStyle(
                //       color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                // ))
                const SizedBox(height: 15),
                Container(
                  width: Get.width * 0.9,
                  child: Row(
                    children: const [
                      BookTag(name: 'Science', icon: Icons.science),
                      SizedBox(width: 20),
                      BookTag(name: 'Romantic', icon: Icons.favorite),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: Get.width * 0.9,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(bookModel.image1.url),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Vikram Negi",
                                        style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "@vikramnegi",
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // width: Get.width * 0.9,
                        child: Stack(
                          children: [
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: vm.showMore ? 100 : 3,
                              text: TextSpan(
                                text: description.length > 117
                                    ? description.toString().substring(0, 117)
                                    : description.toString(),
                                children: [
                                  TextSpan(
                                    text: vm.showMore ? "" : "...",
                                  ),
                                  TextSpan(
                                    text: vm.showMore
                                        ? description.length > 117
                                            ? description.toString().substring(
                                                117, description.length - 1)
                                            : ""
                                        : "",
                                    style: const TextStyle(
                                      // color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.w500,
                                ),
                              ),
                              // style: TextStyle(fontSize: 18),
                            ),
                            description.length > 90
                                ? Positioned(
                                    bottom: -5,
                                    right: 15,
                                    child: Container(
                                      // color: Colors.white,
                                      alignment: Alignment.centerRight,
                                      height: 24,
                                      width: 65,
                                      child: Container(
                                        // color: Colors.white24,
                                        color:
                                            Theme.of(context).backgroundColor,
                                        child: InkWell(
                                          onTap: () {
                                            vm.showMore = !vm.showMore;
                                            vm.update();
                                          },
                                          child: Text(
                                            vm.showMore ? 'less' : "more",
                                            style: const TextStyle(
                                              // color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "More Books by Vikram Negi",
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  height: 175,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                      separatorBuilder: (context, i) {
                        return Column(
                          children: [
                            Image.network(vm.bookList[i].image1.url,
                                height: 140, width: 100, fit: BoxFit.fitHeight),
                            SizedBox(
                              width: 100,
                              child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: vm.bookList[i].bookName,
                                    style: const TextStyle(
                                        // color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        );
                      },
                      itemCount: vm.bookList.length),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            width: Get.width,
            color: Colors.transparent,
            height: 65,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Rent Per Day",
                              style: TextStyle(
                                // color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "₹ ${(bookModel.rentPerDay!).toStringAsFixed(2)}",
                              // "₹ 1200.00",
                              style: const TextStyle(
                                // color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<ProfileVM>(builder: (profileVM) {
                          return ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              // onPrimary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                            onPressed: () async {
                              // Get.to(() => CartView());
                              // vm.addInCartList(bookModel);
                              // vm.increaseQuantity(bookModel);
                              // Get.to(() => OrderPage());
                              if (!vm.isUserLoginedIn) {
                                LoginFirstDialog(Get.context);
                                return;
                              }
                              if (vm.userCity != bookModel.city ||
                                  vm.userState != bookModel.state) {
                                showDialogBox(
                                    Get.context!,
                                    "Can't order Book",
                                    "This Book is From Different city or state",
                                    true);
                                return;
                              }
                              // Get.to(() => PaymentPage(
                              //     price: bookModel.rentPerDay != null
                              //         ? bookModel.rentPerDay!.toDouble()
                              //         : 0.0));
                              vm.purchaseSingleBook(bookModel);
                              await noOfDaysDialogBox(Get.context!,
                                  vm.noOfDaysController, bookModel.id, 0, true);
                              // if (vm.singlebookchange) {
                              profileVM.getAddressList();
                              Get.to(() => UserAddress(
                                  isPayment: true,
                                  total: bookModel.rentPerDay! *
                                      bookModel.quantity! *
                                      1.0));
                              // } else {

                              // }
                            },
                            icon: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.delivery_dining,
                                color: Colors.white,
                              ),
                            ),
                            label: const Text(
                              "Rent Now",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CircularWidget extends StatelessWidget {
  final Color? color;
  Function function;
  final Widget? child;
  final double? size;
  final IconData? icon;
  CircularWidget({
    Key? key,
    this.color,
    required this.function,
    this.size,
    this.child,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade100,
      child: InkWell(
        onTap: () => function(),
        child: Center(
            child: icon != null
                ? Icon(icon, color: color ?? Colors.grey, size: size ?? 25)
                : child),
      ),
    );
  }
}

class BookTag extends StatelessWidget {
  final String name;
  final IconData? icon;

  const BookTag({
    required this.name,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ));
  }
}
