// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookmark/ui/payment/payment.dart';
import 'package:bookmark/ui/payment/payment_viewmodel.dart';
import 'package:bookmark/ui/profile/address/user_address.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:bookmark/utils/skelten_shimmer.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:bookmark/ui/homepage/homepage_vm.dart';

class CartWithFullPaymentDetails extends StatefulWidget {
  CartWithFullPaymentDetails({Key? key}) : super(key: key);
  @override
  State<CartWithFullPaymentDetails> createState() =>
      _CartWithFullPaymentDetailsState();
}

class _CartWithFullPaymentDetailsState
    extends State<CartWithFullPaymentDetails> {
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
          ),
          body: vm.afterPaymentLoader
              ? Center(
                  child: CircularProgressIndicator(),
                )
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
                                  "Your Selected Books",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Theme.of(context).canvasColor,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "You select ${vm.cartfoods.length} books to rent",
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
                        vm.isSingleBookPurchase
                            ? SinglePurchaseWidget()
                            : vm.cartfoods.isEmpty
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
                                          const Text(
                                              "You haven't added any item",
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
                        // totalAmount(paymentVM,
                        //     name: "sub-total",
                        //     price: vm.variousFees.rentalCharge.toDouble()),
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
                        GetBuilder<PaymentVM>(builder: (paymentVM) {
                          return paymentVM.loadBill
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 82,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Address",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width - 100,
                                                      child: RichText(
                                                        maxLines: 2,
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                                color: Theme.of(Get
                                                                        .context!)
                                                                    .primaryColor,
                                                                fontSize: 12),
                                                            text: paymentVM
                                                                .selectedAddress!
                                                                .addressLine1),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    SizedBox(
                                                      width: Get.width - 100,
                                                      child: RichText(
                                                        maxLines: 2,
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                                color: Theme.of(Get
                                                                        .context!)
                                                                    .primaryColor,
                                                                fontSize: 12),
                                                            text: paymentVM
                                                                .selectedAddress!
                                                                .addressLine2),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      // height: 80,
                                      // padding: const EdgeInsets.symmetric(horizontal: 30),
                                      decoration: BoxDecoration(
                                          // color: vm.isSingleBookPurchase
                                          //     ? Colors.black
                                          //     : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFfae3e2)
                                                  .withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(0, 1),
                                            ),
                                          ]),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: paymentVM
                                                    .variousFeesList.length *
                                                33,
                                            child: ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, i) {
                                                  return
                                                      // vm.isSingleBookPurchase
                                                      //     ? totalAmount(
                                                      //         name:
                                                      //             "${vm.variousFeesList[i].entries.first.key}",
                                                      //         price: vm
                                                      //             .variousFeesList[
                                                      //                 i]
                                                      //             .entries
                                                      //             .first
                                                      //             .value)
                                                      //     :
                                                      totalAmount(
                                                          name:
                                                              "${paymentVM.variousFeesList[i].entries.first.key}",
                                                          price: paymentVM
                                                              .variousFeesList[
                                                                  i]
                                                              .entries
                                                              .first
                                                              .value);
                                                },
                                                separatorBuilder: (context, i) {
                                                  return const SizedBox(
                                                      height: 10);
                                                },
                                                itemCount: paymentVM
                                                    .variousFeesList.length),
                                            // itemCount: vm.variousFees.toMap().length),
                                          ),
                                          // totalAmount(vm,
                                          //     name: "sub-total",
                                          //     price: vm.variousFees.totalWithoutCharges
                                          //         .toDouble()),
                                          // totalAmount(vm,
                                          //     name: "Charges",
                                          //     price: vm.cartfoods.isEmpty
                                          //         ? 0.0
                                          //         : vm.getTotalCharges(),
                                          //     icon: Icons.error),
                                          // totalAmount(vm,
                                          //     name: "Total",
                                          //     price: vm.cartfoods.isEmpty
                                          //         ? 0.0
                                          //         : (vm.variousFees.total * 1.0)),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        })
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: GetBuilder<PaymentVM>(builder: (paymentVM) {
            return Container(
              width: Get.width,
              color: Colors.transparent,
              height: 53,
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (vm.cartfoods.isEmpty) {
                      showSnackBar(
                          context, "Please add some items to cart", true);
                    } else if (paymentVM.loadBill) {
                      showSnackBar(context,
                          "Please wait while we are loading data", true);
                    } else {
                      //  Get.to(() => PaymentPage(price: vm.totalPrice));
                      paymentVM.preceedForRazorPay = true;
                      paymentVM.update();
                      paymentVM.createOrder(
                          (paymentVM.chargesByAddress.grandtotal * 100)
                              .toInt());
                      // Get.to(() => PaymentPage(
                      //     price: paymentVM.chargesByAddress.grandtotal));
                      // Get.to(() => UserAddress(isPayment: true, total: vm.totalPrice));
                    }
                  },
                  child: Container(
                    width: Get.width - 45,
                    // width: Get.width < 550 ? Get.width - 45 : Get.width * 0.5,
                    height: 45,
                    decoration: BoxDecoration(
                      color: paymentVM.loadBill
                          ? Colors.grey.shade500
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
                      child: paymentVM.preceedForRazorPay
                          ? Center(
                              child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                              ),
                            ))
                          : Text(
                              paymentVM.loadBill ? "Loading..." : "Checkout",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    // ),
                  ),
                ),
              ),
            );
          }),
        );
      });
    });
  }

  Row totalAmount(
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
                            // Get.defaultDialog(
                            //     title: "Additional Charges",
                            //     titleStyle: const TextStyle(
                            //         fontSize: 20, fontWeight: FontWeight.w600),
                            //     content: Container(
                            //   width: 200,
                            //   child: Column(
                            //     crossAxisAlignment:
                            //         CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //           "Delivery Charges: ${vm.variousFees.deliveryFees}"),
                            //       Text(
                            //           "Service Charges: ${vm.variousFees.internetHandlingFees}"),
                            //       Text(
                            //           "GST Charges: ${vm.variousFees.rentalCharge * 0.18}"),
                            //     ],
                            //   ),
                            // ));
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

class CartItem extends StatelessWidget {
  int index;

  CartItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Container(
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
                          )),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        width: Get.width - 160,
                        height: 110,
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width - 212,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                text: TextSpan(
                                  text: vm.cartfoods[index].book.bookName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w400),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              child: RichText(
                                maxLines: 1,
                                text: TextSpan(
                                  text: "Total : ₹",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          "${(vm.cartfoods[index].book.rentPerDay! * vm.singleBookDays).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF3a3a3b),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: RichText(
                                maxLines: 1,
                                text: TextSpan(
                                  text: "₹",
                                  style: const TextStyle(
                                      fontSize: 24,
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
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                text: "No of Days : ",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "${vm.singleBookDays}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF3a3a3b),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      );
    });
  }
}

class SinglePurchaseWidget extends StatelessWidget {
  const SinglePurchaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentVM>(builder: (vm) {
      return vm.loadBill
          ? Container(
              child: Row(
              children: [
                Skelton(
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skelton(
                      width: 100,
                      height: 20,
                    ),
                    const SizedBox(height: 10),
                    Skelton(
                      width: 100,
                      height: 20,
                    ),
                    const SizedBox(height: 10),
                    Skelton(
                      width: 100,
                      height: 20,
                    ),
                  ],
                ),
              ],
            ))
          : CartItem(index: 0);
    });
  }
}
