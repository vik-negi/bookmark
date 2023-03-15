// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookmark/ui/payment/payment.dart';
import 'package:bookmark/ui/profile/address/user_address.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:bookmark/utils/login_first_dialog.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:bookmark/ui/homepage/homepage_vm.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int counter = 3;

  DiningVM vm = Get.isRegistered<DiningVM>() ? Get.find() : Get.put(DiningVM());
  ProfileVM profilVM =
      Get.isRegistered<ProfileVM>() ? Get.find() : Get.put(ProfileVM());

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<DiningVM>(builder: (vm) {
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: const Color(0xFFFAFAFA),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                // color: Color(0xFF3a3737),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              "Your Cart",
              style: TextStyle(
                  // color: Color(0xFF3a3737),
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            brightness: Brightness.light,
            actions: <Widget>[
              !vm.showCartSelectOption
                  ? SizedBox()
                  : CartIconWithBadge(
                      no: vm.selectedCartList.length,
                      icon: Icons.delete,
                      onPressed: () {
                        vm.selectedCartList.isEmpty
                            ? showSnackBar(
                                context,
                                "Please select at least one item to delete",
                                true)
                            : vm.deleteSelectedCartItems();
                      },
                    ),
            ],
          ),
          body: vm.getCartItemsLoader
              ? Center(child: CircularProgressIndicator.adaptive())
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                // color: Colors.black,
                                size: 30),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Added Cart Books",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Theme.of(context).canvasColor,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "You have ${vm.cartfoods.length} books in your cart",
                                  // "kmk",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      // color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        vm.cartfoods.isEmpty
                            ? Container(
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
                                      const Text("You haven't added any item",
                                          style: TextStyle(fontSize: 18))
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: vm.cartfoods.length * 140,
                                child: vm.cartfoods.isEmpty
                                    ? const Text("Empty Card")
                                    : ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return CartItem(index: i);
                                        },
                                        separatorBuilder: (context, i) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                        itemCount: vm.cartfoods.length)),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(boxShadow: [
                        //     BoxShadow(
                        //       color: const Color(0xFFfae3e2).withOpacity(0.1),
                        //       spreadRadius: 1,
                        //       blurRadius: 1,
                        //       offset: const Offset(0, 1),
                        //     ),
                        //   ]),
                        //   height: vm.cartfoods.length * 75,
                        //   child: ListView.separated(
                        //       physics: const NeverScrollableScrollPhysics(),
                        //       itemBuilder: (context, i) {
                        //         return TotalCalculationWidget(
                        //           name: vm.cartfoods[i].book.bookName,
                        //           price: vm.cartfoods[i].book.rentPerDay! *
                        //               (vm.cartfoods[i].noOfDays) *
                        //               1.0,
                        //         );
                        //       },
                        //       separatorBuilder: ((context, index) => const SizedBox(
                        //             height: 5,
                        //           )),
                        //       itemCount: vm.cartfoods.length),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        // TotalCalculationWidget(
                        //     fontSize: 22, name: "total", price: vm.totalPrice),
                        // Container(
                        //   padding: const EdgeInsets.only(left: 5),
                        //   child: const Text(
                        //     "Payment Method",
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         color: Color(0xFF3a3a3b),
                        //         fontWeight: FontWeight.w600),
                        //     textAlign: TextAlign.left,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // PaymentMethodWidget(),
                        // Container(
                        //   // height: 80,
                        //   // padding: const EdgeInsets.symmetric(horizontal: 30),
                        //   decoration: BoxDecoration(
                        //       // color: Colors.red,
                        //       borderRadius: BorderRadius.circular(10),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: const Color(0xFFfae3e2).withOpacity(0.1),
                        //           spreadRadius: 1,
                        //           blurRadius: 1,
                        //           offset: const Offset(0, 1),
                        //         ),
                        //       ]),
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         height: vm.variousFeesList.length * 33,
                        //         child: ListView.separated(
                        //             physics: const NeverScrollableScrollPhysics(),
                        //             itemBuilder: (context, i) {
                        //               return totalAmount(vm,
                        //                   name:
                        //                       "${vm.variousFeesList[i].entries.first.key}",
                        //                   price: vm.variousFeesList[i].entries.first
                        //                       .value);
                        //             },
                        //             separatorBuilder: (context, i) {
                        //               return const SizedBox(height: 10);
                        //             },
                        //             itemCount: vm.variousFeesList.length),
                        //         // itemCount: vm.variousFees.toMap().length),
                        //       ),
                        //       // totalAmount(vm,
                        //       //     name: "sub-total",
                        //       //     price: vm.variousFees.totalWithoutCharges
                        //       //         .toDouble()),
                        //       // totalAmount(vm,
                        //       //     name: "Charges",
                        //       //     price: vm.cartfoods.isEmpty
                        //       //         ? 0.0
                        //       //         : vm.getTotalCharges(),
                        //       //     icon: Icons.error),
                        //       // totalAmount(vm,
                        //       //     name: "Total",
                        //       //     price: vm.cartfoods.isEmpty
                        //       //         ? 0.0
                        //       //         : (vm.variousFees.total * 1.0)),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: Container(
            width: Get.width,
            color: Colors.transparent,
            height: 72,
            child: Column(
              children: [
                vm.getCartItemsLoader
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: totalAmount(vm,
                            name: "Total",
                            price: vm.variousFees.rentalCharge.toDouble()),
                      ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (vm.cartfoods.isEmpty) {
                        showSnackBar(
                            context, "Please add some items to cart", true);
                      }
                      if (vm.getCartItemsLoader) {
                        showSnackBar(context,
                            "Please wait while we are loading data", true);
                      } else {
                        //  Get.to(() => PaymentPage(price: vm.totalPrice));
                        profilVM.getAddressList();
                        Get.to(() =>
                            UserAddress(isPayment: true, total: vm.totalPrice));
                      }
                    },
                    child: Container(
                      width: Get.width - 45,
                      // width: Get.width < 550 ? Get.width - 45 : Get.width * 0.5,
                      height: 45,
                      decoration: BoxDecoration(
                        color: vm.getCartItemsLoader
                            ? Colors.grey.shade700
                            : Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFfae3e2).withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          vm.getCartItemsLoader ? "Loading..." : "Proceed",
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  Row totalAmount(DiningVM vm,
      {double? fontSize, String? name, required double price, IconData? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(name ?? "Total",
                style: TextStyle(
                  fontSize: fontSize ?? 18,
                  fontWeight:
                      name == "Total" ? FontWeight.w500 : FontWeight.w600,
                  color: name == "Total" ? Colors.black : Color(0xff707b81),
                )),
            icon != null ? const SizedBox(width: 5) : SizedBox(),
            icon != null
                ? Row(
                    children: [
                      const SizedBox(width: 5),
                      InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: "Additional Charges",
                                titleStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                content: Container(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Delivery Charges: ${vm.variousFees.deliveryFees}"),
                                      Text(
                                          "Service Charges: ${vm.variousFees.internetHandlingFees}"),
                                      Text(
                                          "GST Charges: ${vm.variousFees.rentalCharge * 0.18}"),
                                    ],
                                  ),
                                ));
                          },
                          child: Icon(icon, size: 20))
                    ],
                  )
                : SizedBox(),
          ],
        ),
        Text("₹ ${price.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: fontSize ?? 18,
              fontWeight: name == "Total" ? FontWeight.w500 : FontWeight.w600,
              color: name == "Total" ? Color(0xff1a252f) : Color(0xff707b81),
            )),
      ],
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          // color: const Color(0xFFfae3e2).withOpacity(1),
          color: Colors.white,
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ]),
      // child: Container(
      // alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/menus/ic_credit_card.png",
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Credit/Debit Card",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          )
        ],
      ),
      // ),
    );
  }
}

class TotalCalculationWidget extends StatelessWidget {
  final String name;
  final double price;
  final double? fontSize;
  const TotalCalculationWidget(
      {super.key, required this.name, required this.price, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: const Color(0xFFfae3e2).withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ]),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 25, right: 30, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: name == "total" ? Get.width - 280 : Get.width - 200,
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              text: TextSpan(
                text: name,
                style: TextStyle(
                    fontSize: fontSize ?? 18,
                    color: const Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w400),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Text(
            "₹ $price",
            style: TextStyle(
                fontSize: fontSize ?? 18,
                color: const Color(0xFF3a3a3b),
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}

class PromoCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 3, right: 3),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color(0xFFfae3e2).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ]),
        child: TextFormField(
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFe6e1e1), width: 1.0),
                  borderRadius: BorderRadius.circular(7)),
              fillColor: Colors.white,
              hintText: 'Add Your Promo Code',
              hintStyle: const TextStyle(
                color: Color(0xFF3a3a3b),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.local_offer,
                    color: Color(0xFFfd2c2c),
                  ),
                  onPressed: () {
                    debugPrint('222');
                  })),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  int index;

  CartItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return GestureDetector(
        onLongPress: () {
          print("long press");
          vm.showCartSelectOption = true;
          vm.update();
        },
        onDoubleTap: () {
          print("double tap");
          vm.showCartSelectOption = false;
          vm.update();
        },
        child: Container(
          width: double.infinity,
          height: 135,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: const Color(0xFFfae3e2).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ]),
          child: Row(
            children: [
              vm.showCartSelectOption == true
                  ? Container(
                      padding: const EdgeInsets.all(0),
                      width: 20,
                      height: 135,
                      child: Checkbox(
                        value:
                            vm.selectedCartList.contains(vm.cartfoods[index]),
                        onChanged: (value) {
                          value == true
                              ? vm.selectedCartList.add(vm.cartfoods[index])
                              : vm.selectedCartList.remove(vm.cartfoods[index]);
                          vm.update();
                        },
                      ),
                    )
                  : Container(),
              Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFfae3e2).withOpacity(1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 0),
                            ),
                          ]),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                  vm.cartfoods[index].book.image1.url,
                                  width: 110,
                                  height: 130,
                                  fit: BoxFit.cover),
                            )
                                //   Image.asset(
                                // "assets/images/popular_foods/$productImage.png",
                                // width: 110,
                                // height: 100,
                                // )
                                ),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          width: vm.showCartSelectOption
                              ? Get.width - 190
                              : Get.width - 160,
                          height: 110,
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // const SizedBox(
                              //   height: 1,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Get.width - 212,
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                text: TextSpan(
                                                  text: vm.cartfoods[index].book
                                                      .bookName,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF3a3a3b),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: "Total : ₹",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF3a3a3b),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          "${(vm.cartfoods[index].book.rentPerDay! * vm.cartfoods[index].noOfDays).toStringAsFixed(2)}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xFF3a3a3b),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   width: 40,
                                    // ),
                                    vm.showCartSelectOption == true
                                        ? SizedBox()
                                        : Container(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                // vm.removeDirectly(
                                                //     vm.cartfoods[index].book);
                                                vm.selectedCartList.clear();
                                                vm.selectedCartList
                                                    .add(vm.cartfoods[index]);
                                                vm.deleteSelectedCartItems();
                                              },
                                              child: Icon(Icons.delete,
                                                  color: Colors.red.shade400,
                                                  size: 32),
                                            ))
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerRight,
                                    child: AddToCartMenu(index),
                                  ),
                                  Container(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "₹",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Color(0xFF3a3a3b),
                                            fontWeight: FontWeight.w400),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                "${vm.cartfoods[index].book.rentPerDay}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text: " Per Day",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF3a3a3b),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}

class CartIconWithBadge extends StatelessWidget {
  int no = 3;
  IconData icon;
  Function()? onPressed;
  CartIconWithBadge({
    Key? key,
    required this.no,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(
              icon,
              // color: Color(0xFF3a3737),
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
              }
            }),
        no != 0
            ? Positioned(
                right: 8,
                bottom: 17,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$no',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  int index;

  AddToCartMenu(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              // vm.decreaseCartItemQty(vm.cartfoods[index]);
              noOfDaysDialogBox(Get.context!, vm.noOfDaysController,
                  vm.cartfoods[index].book.id, index, false);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              vm.cartfoods[index].noOfDays.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1f1f),
                  fontWeight: FontWeight.w400),
            ),
          ),
          InkWell(
            onTap: () {
              // vm.addInCartList(vm.cartfoods[index]);
              // vm.increaseQuantity(vm.cartfoods[index]);
              noOfDaysDialogBox(Get.context!, vm.noOfDaysController,
                  vm.cartfoods[index].book.id, index, false);
              // vm.increaseCartItemQty(vm.cartfoods[index]);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

      // Row(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.all(5),
      //       decoration: BoxDecoration(
      //         color: Colors.black,
      //         borderRadius: BorderRadius.circular(5),
      //       ),
      //       child: const Icon(
      //         Icons.remove,
      //         color: Colors.white,
      //       ),
      //     ),
      //     Container(
      //       margin: const EdgeInsets.only(left: 10, right: 10),
      //       child:  Text(
      //         vm.cartfoods[index].quantity.toString(),
      //          vm.data!.quantity.toString(),
      //         style: TextStyle(
      //             fontSize: 16,
      //             color: Color(0xFF1f1f1f),
      //             fontWeight: FontWeight.w400),
      //       ),
      //     ),
      //     Container(
      //       padding: const EdgeInsets.all(5),
      //       margin: const EdgeInsets.only(right: 10),
      //       decoration: BoxDecoration(
      //         color: Colors.black,
      //         borderRadius: BorderRadius.circular(5),
      //       ),
      //       child: const Icon(
      //         Icons.add,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // );
    });
  }
}
