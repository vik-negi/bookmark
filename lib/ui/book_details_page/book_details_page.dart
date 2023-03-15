import 'package:flutter/material.dart';
import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/constants/textstyles.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/book_details_page/food_details_page_viewmodel.dart';
import 'package:bookmark/ui/main/order_page.dart';
import 'package:get/get.dart';

import '../../model/book.dart';

class FoodDetailsPage extends StatelessWidget {
  Book bookModel;
  FoodDetailsPage({Key? key, required this.bookModel}) : super(key: key);
  @override
  DiningVM vm = Get.put(DiningVM());

  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFFFAFAFA),
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Color(0xFF3a3737),
        //     ),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   brightness: Brightness.light,
        //   actions: <Widget>[
        //     IconButton(
        //         icon: const Icon(
        //           Icons.business_center,
        //           color: Color(0xFF3a3737),
        //         ),
        //         onPressed: () {
        //           // Get.to(()=>FoodOrderPage());
        //         })
        //   ],
        // ),

        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    child: Image.network(
                      bookModel.thumbnail!,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Card(
                  //   semanticContainer: true,
                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                  //   child: Image.asset(
                  //     'assets/images/bestfood/' + 'ic_best_food_8' + ".jpeg",
                  //   ),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(3.0),
                  //   ),
                  //   elevation: 1,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 0,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: Get.width - 137,
                                  child: RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                      text: bookModel.title!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF3a3a3b),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "by ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFa9a9a9),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Mom's Kitchen",
                                      style: TextStyle(
                                          fontSize: 16,
                                          // color: Color(0xFF1f1f1f),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    debugPrint("${bookModel.currentPrice!}");
                                    // vm.decreaseQuantity(bookModel);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      // color: Colors.white,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    bookModel.quantity.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        // color: Color(0xFF1f1f1f),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // vm.addInCartList(bookModel);
                                    // vm.increaseQuantity(bookModel);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).hintColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        const PreferredSize(
                          preferredSize: Size.fromHeight(50.0),
                          child: TabBar(
                            labelColor: Color(0xFFfd3f40),
                            indicatorColor: Color(0xFFfd3f40),
                            unselectedLabelColor: Color(0xFFa4a1a1),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            tabs: [
                              Tab(
                                text: 'Food Details',
                              ),
                              Tab(
                                text: 'Food Reviews',
                              ),
                            ], // list of tabs
                          ),
                        ),
                        Container(
                          height: 150,
                          child: TabBarView(
                            children: [
                              Container(
                                // color: Colors.white24,
                                child: DetailContentMenu(),
                              ),
                              Container(
                                // color: Colors.white24,
                                child: DetailContentMenu(),
                              ), // class name
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: Get.width,
                          child: const Text("Similar Books",
                              style: TextStyle(
                                  fontSize: 20,
                                  // color: Color(0xFF3a3a3b),
                                  fontWeight: FontWeight.w500)),
                        ),

                        GetBuilder<DiningVM>(builder: (diningVM) {
                          return Container(
                              height: 240,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: diningVM.relatedBookList.length ~/ 2,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: AppColors.separatorGrey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(26)),
                                      color: AppColors.whiteColor,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              constraints:
                                                  const BoxConstraints.expand(
                                                      height: 220.0,
                                                      width: 280),
                                              alignment: Alignment.bottomLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                  bottom: 8.0,
                                                  top: 8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(26),
                                                image: DecorationImage(
                                                  image: NetworkImage(diningVM
                                                      .relatedBookList[index]
                                                      .image1
                                                      .url),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .persianColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        child: const Text(
                                                            'Daily Temperature checks',
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: AppColors
                                                                    .whiteColor)),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 10,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0,
                                                                  vertical:
                                                                      2.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .highlighterBlueDark,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: RichText(
                                                            maxLines: 1,
                                                            text: TextSpan(
                                                              text: diningVM
                                                                          .relatedBookList[
                                                                              index]
                                                                          .bookName
                                                                          .length >
                                                                      15
                                                                  ? diningVM
                                                                      .relatedBookList[
                                                                          index]
                                                                      .bookName
                                                                      .substring(
                                                                          0, 15)
                                                                  : diningVM
                                                                      .relatedBookList[
                                                                          index]
                                                                      .bookName,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Row(
                                                              children: const [
                                                                Text(
                                                                  "4.9 ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Icon(Icons.star,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 22)
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   padding: const EdgeInsets.only(
                                                  //       left: 5,
                                                  //       right: 10,
                                                  //       top: 5,
                                                  //       bottom: 5),
                                                  //   decoration: BoxDecoration(
                                                  //       color: AppColors
                                                  //           .highlighterBlueDark,
                                                  //       borderRadius:
                                                  //           BorderRadius.circular(
                                                  //               5.0)),
                                                  //   child: const Text(
                                                  //       '30% OFF - no code required',
                                                  //       style: TextStyle(
                                                  //           fontSize: 12.0,
                                                  //           color: AppColors
                                                  //               .whiteColor)),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ));
                        }),
                        // BottomMenu(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "₹ ${vm.totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              // color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          // onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        onPressed: () {
                          // Get.to(() => CartView());
                          Get.to(() => OrderPage());
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
                          "Checkout",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
      );
    });
  }
}

class FoodTitleWidget extends StatelessWidget {
  String productName;
  String productPrice;
  String productHost;

  FoodTitleWidget({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productHost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              productName,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              productPrice,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            const Text(
              "by ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFa9a9a9),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              productHost,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1f1f),
                  fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }
}

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Icon(
                Icons.timelapse,
                color: Color(0xFF404aff),
                size: 35,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "12pm-3pm",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              const Icon(
                Icons.directions,
                color: Color(0xFF23c58a),
                size: 35,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "3.5 km",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              const Icon(
                Icons.map,
                color: Color(0xFFff0654),
                size: 35,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Map View",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Column(
            children: <Widget>[
              const Icon(
                Icons.directions_bike,
                color: Color(0xFFe95959),
                size: 35,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Delivery",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFa9a9a9),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove),
            // color: Colors.black,
            iconSize: 30,
          ),
          InkWell(
            onTap: () {
              // Get.to(()=> FoodOrderPage());
            },
            child: Container(
              width: 200.0,
              height: 45.0,
              decoration: BoxDecoration(
                color: const Color(0xFFfd2c2c),
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  'Add To Bag',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            color: const Color(0xFFfd2c2c),
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}

class DetailContentMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).dividerColor,
      child: Column(
        children: [
          order_details_tile(Icons.alarm, "approx 30 min"),
          const SizedBox(
            height: 10,
          ),
          order_details_tile(
              Icons.location_pin, "2.5 km | Rajiv chowk new delhi"),
        ],
      ),
    );
  }

  Row order_details_tile(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14.0,
              // color: Colors.black87,
              fontWeight: FontWeight.w400,
              height: 1.50),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
